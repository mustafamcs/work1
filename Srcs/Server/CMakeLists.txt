# ============================================================================
# Server — tek kaynak agacindan iki hedef:
#   Windows : MSVC v143 (VS2022), x86
#   FreeBSD : Clang
#
# Kullanim (ek -D gerekmez):
#   cmake -S . -B build
#   cmake --build build
# ============================================================================
cmake_minimum_required(VERSION 3.15)

# vcxproj'ler Win32 (x86) hedefliyor; Srcs/Extern/lib altindaki .lib'ler de x86.
# VS ureteci icin platformu burada sabitliyoruz. (Ninja kullanilacaksa
# "x86 Native Tools Command Prompt for VS 2022" ortamindan calistirin.
# -A ile acik secim yapildiysa ona saygi duyulur.)
if(NOT CMAKE_GENERATOR_PLATFORM AND CMAKE_GENERATOR MATCHES "Visual Studio")
    set(CMAKE_GENERATOR_PLATFORM "Win32" CACHE INTERNAL "vcxproj uyumu: x86" FORCE)
endif()

project(Server LANGUAGES C CXX)

set(CMAKE_C_STANDARD 17)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(NOT WIN32 AND NOT CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
    message(FATAL_ERROR "Desteklenmeyen platform: ${CMAKE_SYSTEM_NAME} (Windows veya FreeBSD gerekli)")
endif()

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Derleme tipi" FORCE)
endif()

# --- Dis bagimliliklar: Srcs/Extern ---------------------------------------
get_filename_component(EXTERN_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../Extern" ABSOLUTE)
set(EXTERN_INCLUDE_DIR "${EXTERN_DIR}/include")
set(EXTERN_LIB_DIR     "${EXTERN_DIR}/lib")
set(EXTERN_DLL_DIR     "${EXTERN_DIR}/dll")

# --- Cikti duzeni ---------------------------------------------------------
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")

# --- Ortak arayuz: server_base --------------------------------------------
# Butun hedefler bunu baglar: uyari bayraklari, Extern include yollari,
# OS tanimlari. Uyarilar her iki hedefte de hata sayilir (/WX, -Werror).
add_library(server_base INTERFACE)
target_include_directories(server_base INTERFACE
    "${EXTERN_INCLUDE_DIR}" "${EXTERN_DIR}")

if(MSVC)
    # vcxproj RuntimeLibrary: MultiThreaded(/Debug) — statik CRT
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    target_compile_options(server_base INTERFACE
        /utf-8 /Zc:preprocessor /MP /W3
        # /WX yok: derleyici cache saricilari (sccache/buildcache) preprocess
        # adiminda /wd bastirmalarini atlar; cikan uyari /WX ile hataya donusur.
        # OutputPaths.props'taki DisableSpecificWarnings listesi
        /wd4996 /wd5054 /wd5055 /wd4244 /wd4242 /wd4267 /wd4838 /wd4805
        /wd4146 /wd4018 /wd4309 /wd4804 /wd4101 /wd4065 /wd4477 /wd4005 /wd4834)
    target_compile_definitions(server_base INTERFACE
        WIN32 NOMINMAX __WIN32__ _WIN32 _CONSOLE
        _CRT_SECURE_NO_WARNINGS _WINSOCK_DEPRECATED_NO_WARNINGS _USE_32BIT_TIME_T)
elseif(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
    # FreeBSD Makefile'lari -m32 (32-bit) ile derliyor
    target_compile_options(server_base INTERFACE
        -m32 -Wall -Werror -fstack-protector-all
        # Makefile'lardaki Wno- listesi (eski kod tabani icin gerekli)
        -Wno-unknown-warning-option -Wno-invalid-source-encoding
        -Wno-deprecated-declarations -Wno-nonnull-compare -Wno-array-bounds
        -Wno-address -Wno-int-in-bool-context -Wno-format-truncation
        -Wno-stringop-truncation -Wno-sign-compare
        -Wno-deprecated-enum-enum-conversion -Wno-deprecated-anon-enum-enum-conversion
        -Wno-long-long -Wno-unused-local-typedefs)
    target_link_options(server_base INTERFACE -m32)
    target_include_directories(server_base INTERFACE /usr/local/include)
    target_compile_definitions(server_base INTERFACE _THREAD_SAFE)
    set(THREADS_PREFER_PTHREAD_FLAG ON)
    find_package(Threads REQUIRED)
    target_link_libraries(server_base INTERFACE Threads::Threads)
endif()

# --- OS'e ozel dis kutuphaneler -------------------------------------------
if(WIN32)
    # vcxproj AdditionalDependencies -> Srcs/Extern/lib altindaki .lib'ler
    find_library(EXTERN_MYSQL_LIB    NAMES libmysql                  PATHS "${EXTERN_LIB_DIR}" NO_DEFAULT_PATH)
    find_library(EXTERN_DEVIL_LIB    NAMES DevIL                     PATHS "${EXTERN_LIB_DIR}" NO_DEFAULT_PATH)
    find_library(EXTERN_ILU_LIB      NAMES ILU                       PATHS "${EXTERN_LIB_DIR}" NO_DEFAULT_PATH)
    find_library(EXTERN_ILUT_LIB     NAMES ILUT                      PATHS "${EXTERN_LIB_DIR}" NO_DEFAULT_PATH)
    find_library(EXTERN_CRYPTOPP_LIB NAMES cryptlib-Release cryptlib PATHS "${EXTERN_LIB_DIR}" NO_DEFAULT_PATH)
    foreach(_v IN ITEMS EXTERN_MYSQL_LIB EXTERN_DEVIL_LIB EXTERN_ILU_LIB
                        EXTERN_ILUT_LIB EXTERN_CRYPTOPP_LIB)
        if(NOT ${_v})
            message(FATAL_ERROR "${_v}: ${EXTERN_LIB_DIR} altinda bulunamadi")
        endif()
    endforeach()
elseif(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
    # MySQL/MariaDB istemcisi: once sistem, yoksa Extern'deki statik arsiv
    find_path(MYSQLCLIENT_INCLUDE_DIR NAMES mysql/mysql.h
        PATHS /usr/local/include /usr/include)
    find_library(MYSQLCLIENT_LIB NAMES mysqlclient mariadbclient mariadb
        PATHS /usr/local/lib /usr/local/lib/mysql /usr/lib)
    if(NOT MYSQLCLIENT_LIB AND EXISTS "${EXTERN_LIB_DIR}/libmysqlclient.a")
        set(MYSQLCLIENT_LIB "${EXTERN_LIB_DIR}/libmysqlclient.a")
        if(NOT MYSQLCLIENT_INCLUDE_DIR)
            set(MYSQLCLIENT_INCLUDE_DIR "${EXTERN_INCLUDE_DIR}")
        endif()
    endif()
    if(NOT MYSQLCLIENT_LIB)
        message(FATAL_ERROR "FreeBSD: mysql istemcisi bulunamadi (pkg: mariadb-client/mysql-client veya ${EXTERN_LIB_DIR}/libmysqlclient.a)")
    endif()
    if(MYSQLCLIENT_INCLUDE_DIR)
        target_include_directories(server_base INTERFACE "${MYSQLCLIENT_INCLUDE_DIR}")
    endif()

    # DevIL / Crypto++: Makefile'lar Extern'deki .a dosyalarini kullaniyor
    find_library(DEVIL_LIB    NAMES IL                PATHS "${EXTERN_LIB_DIR}" /usr/local/lib)
    find_library(CRYPTOPP_LIB NAMES cryptopp cryptlib PATHS "${EXTERN_LIB_DIR}" /usr/local/lib)
    find_library(Z_LIB        NAMES z)
    find_library(MD_LIB       NAMES md)
    find_package(OpenSSL QUIET)
    if(OpenSSL_FOUND)
        set(SERVER_SSL_LIBS OpenSSL::SSL OpenSSL::Crypto)
    else()
        set(SERVER_SSL_LIBS ssl crypto)
    endif()

    # version.cpp icin surum tanimlari (Makefile ile ayni)
    file(READ "${CMAKE_CURRENT_SOURCE_DIR}/__REVISION__" SERVER_REVISION)
    string(STRIP "${SERVER_REVISION}" SERVER_REVISION)
    cmake_host_system_information(RESULT SERVER_HOSTNAME QUERY HOSTNAME)
    set(SERVER_BUILD_USER "$ENV{USER}")
endif()

# --- Alt hedefler ----------------------------------------------------------
add_subdirectory(platform)    # OS soyutlama katmani (statik)
add_subdirectory(libthecore)  # -> thecore
add_subdirectory(liblua)      # -> lua (5.0; 5.2 kaynaklari vcxproj'de yok)
add_subdirectory(libsql)      # -> sql
add_subdirectory(libpoly)     # -> poly
add_subdirectory(libgame)     # -> lgame
add_subdirectory(db)          # -> db / db.exe
add_subdirectory(game)        # -> game / game.exe ve qc / qc.exe

# control: baska ajan yaziyor — kaynak varsa hedef ekle
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/control/CMakeLists.txt")
    add_subdirectory(control)
elseif(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/control/control.cpp")
    add_executable(control control/control.cpp)
    target_link_libraries(control PRIVATE platform server_base)
    if(WIN32)
        target_link_libraries(control PRIVATE ws2_32)
    endif()
endif()
