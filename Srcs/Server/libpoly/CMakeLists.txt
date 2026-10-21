# libpoly — ifade cozumleyici (libpoly.vcxproj ile ayni liste)
# FreeBSD Makefile'inda main.cc yok: icinde bagimsiz bir test main()'i var.
set(POLY_SOURCES
    Base.cc
    Poly.cc
    SymTable.cc
    Symbol.cc)

if(WIN32)
    list(APPEND POLY_SOURCES main.cc) # vcxproj listesinde var; statik lib'te zararsiz
endif()

add_library(poly STATIC ${POLY_SOURCES})
target_include_directories(poly PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}")
target_link_libraries(poly PUBLIC server_base)

if(WIN32)
    set_target_properties(poly PROPERTIES OUTPUT_NAME libpoly DEBUG_POSTFIX "_d")
    target_compile_definitions(poly PRIVATE _LIB)
elseif(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
    target_compile_options(poly PRIVATE -fno-exceptions -fno-rtti)
endif()
