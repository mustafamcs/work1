# libthecore — ag/log/zamanlayici cekirdek kutuphanesi
# Kaynak listesi libthecore.vcxproj ile ayni; FreeBSD Makefile'inda
# Windows shim'leri (xdirent/xgetopt/xmd5) yer almaz (BSD'de sistem karsiligi var).
set(THECORE_SOURCES
    src/DES_table.c
    src/buffer.c
    src/des.c
    src/fdwatch.c
    src/gost.c
    src/hangul.c
    src/heart.c
    src/kstbl.c
    src/log.c
    src/main.c
    src/memcpy.c
    src/signal.c
    src/socket.c
    src/tea.c
    src/utils.c)

if(WIN32)
    list(APPEND THECORE_SOURCES
        src/xdirent.c   # dirent shim
        src/xgetopt.c   # getopt shim
        src/xmd5.c)     # md5 (BSD'de libmd var)
endif()

add_library(thecore STATIC ${THECORE_SOURCES})
target_include_directories(thecore PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(thecore PUBLIC server_base)

# Her iki Makefile/vcxproj de .c dosyalarini C++ derleyiciyle derliyor
set_source_files_properties(${THECORE_SOURCES} PROPERTIES LANGUAGE CXX)

if(WIN32)
    # vcxproj cikti adi: libthecore.lib (Debug: libthecore_d.lib)
    set_target_properties(thecore PROPERTIES OUTPUT_NAME libthecore DEBUG_POSTFIX "_d")
    target_link_libraries(thecore PUBLIC ws2_32)
    target_compile_definitions(thecore PRIVATE _LIB _CRT_SECURE_NO_DEPRECATE)
elseif(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
    target_link_libraries(thecore PUBLIC md m)
endif()
