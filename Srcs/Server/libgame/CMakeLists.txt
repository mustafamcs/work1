# libgame — ortak oyun yardimcilari (attribute/grid/targa)
# CMake hedef adi "lgame" (exe hedefi "game" ile cakismasin diye).
add_library(lgame STATIC
    src/attribute.cc
    src/grid.cc
    src/targa.cc)

target_include_directories(lgame PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include")
target_link_libraries(lgame PUBLIC server_base thecore)

if(WIN32)
    set_target_properties(lgame PROPERTIES OUTPUT_NAME libgame DEBUG_POSTFIX "_d")
    target_compile_definitions(lgame PRIVATE _LIB _CRT_SECURE_NO_DEPRECATE)
elseif(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
    target_compile_options(lgame PRIVATE -fno-exceptions)
endif()
