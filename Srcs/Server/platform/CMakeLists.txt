# platform — OS soyutlama katmani (statik kutuphane).
# Kaynak OS'e gore secilir; ortak arayuz platform.h'dir.
set(PLATFORM_SOURCES platform.h)

if(WIN32)
    list(APPEND PLATFORM_SOURCES win/platform_win.cpp)
elseif(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
    list(APPEND PLATFORM_SOURCES freebsd/platform_freebsd.cpp)
endif()

add_library(platform STATIC ${PLATFORM_SOURCES})
target_include_directories(platform PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}")
target_link_libraries(platform PUBLIC server_base)

if(WIN32)
    target_link_libraries(platform PUBLIC ws2_32)
    set_target_properties(platform PROPERTIES DEBUG_POSTFIX "_d")
endif()
