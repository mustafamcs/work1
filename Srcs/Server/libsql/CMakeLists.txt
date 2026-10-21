# libsql — asenkron MySQL istemci sarmalayici (libsql.vcxproj ile ayni liste)
add_library(sql STATIC
    AsyncSQL.cpp
    Semaphore.cpp
    Statement.cpp
    Tellwait.cpp)

target_include_directories(sql PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}")
target_link_libraries(sql PUBLIC server_base thecore)
# mysql basliklari: Windows -> Extern/include/mysql, FreeBSD -> MYSQLCLIENT_INCLUDE_DIR
# (ikisi de server_base uzerinden geliyor)

if(WIN32)
    set_target_properties(sql PROPERTIES OUTPUT_NAME libsql DEBUG_POSTFIX "_d")
    target_compile_definitions(sql PRIVATE _LIB)
elseif(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
    target_compile_options(sql PRIVATE -fno-exceptions)
endif()
