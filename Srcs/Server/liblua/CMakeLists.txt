# liblua — Lua 5.0 (core + standart kutuphane tek statik kutuphanede).
# Kaynak listesi liblua.vcxproj ile ayni. liblua/5.2 kaynaklari duruyor
# ama ne vcxproj ne ust Makefile onu derlemiyor (aktif degil).
set(LUA_SOURCES
    5.0/src/lapi.c
    5.0/src/lcode.c
    5.0/src/ldebug.c
    5.0/src/ldo.c
    5.0/src/ldump.c
    5.0/src/lfunc.c
    5.0/src/lgc.c
    5.0/src/llex.c
    5.0/src/lmem.c
    5.0/src/lobject.c
    5.0/src/lopcodes.c
    5.0/src/lparser.c
    5.0/src/lstate.c
    5.0/src/lstring.c
    5.0/src/ltable.c
    5.0/src/ltests.c
    5.0/src/ltm.c
    5.0/src/lundump.c
    5.0/src/lvm.c
    5.0/src/lzio.c
    5.0/src/lib/lauxlib.c
    5.0/src/lib/lbaselib.c
    5.0/src/lib/ldblib.c
    5.0/src/lib/liolib.c
    5.0/src/lib/lmathlib.c
    5.0/src/lib/loadlib.c
    5.0/src/lib/lstrlib.c
    5.0/src/lib/ltablib.c)

add_library(lua STATIC ${LUA_SOURCES})
target_include_directories(lua PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/5.0/include")
target_link_libraries(lua PRIVATE server_base)

if(MSVC)
    # vcxproj: CompileAs=CompileAsCpp (FreeBSD Makefile C olarak derliyor)
    set_source_files_properties(${LUA_SOURCES} PROPERTIES LANGUAGE CXX)
endif()

if(WIN32)
    # vcxproj cikti adi: liblua.lib (Debug: liblua_d.lib)
    set_target_properties(lua PROPERTIES OUTPUT_NAME liblua DEBUG_POSTFIX "_d")
    target_compile_definitions(lua PRIVATE _LIB _CRT_SECURE_NO_DEPRECATE)
endif()
