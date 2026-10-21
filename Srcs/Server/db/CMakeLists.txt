# db — db sunucusu (db.vcxproj ClCompile listesi ile ayni, 30 kaynak)
set(DB_SOURCES
    src/Cache.cpp
    src/ClientManager.cpp
    src/ClientManagerBoot.cpp
    src/ClientManagerEventFlag.cpp
    src/ClientManagerGuild.cpp
    src/ClientManagerHorseName.cpp
    src/ClientManagerIkarusShop.cpp
    src/ClientManagerLogin.cpp
    src/ClientManagerParty.cpp
    src/ClientManagerPlayer.cpp
    src/Config.cpp
    src/CsvReader.cpp
    src/DBManager.cpp
    src/GuildManager.cpp
    src/HB.cpp
    src/IkarusShopCache.cpp
    src/ItemAwardManager.cpp
    src/ItemIDRangeManager.cpp
    src/Lock.cpp
    src/LoginData.cpp
    src/Main.cpp
    src/Marriage.cpp
    src/Monarch.cpp
    src/MoneyLog.cpp
    src/NetBase.cpp
    src/Peer.cpp
    src/PeerBase.cpp
    src/PrivManager.cpp
    src/ProtoReader.cpp
    src/version.cpp)

add_executable(db ${DB_SOURCES})
target_include_directories(db PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/src")
target_link_libraries(db PRIVATE server_base platform thecore sql poly lgame)

if(WIN32)
    # vcxproj AdditionalDependencies: libmysql.lib ws2_32.lib
    target_link_libraries(db PRIVATE "${EXTERN_MYSQL_LIB}" ws2_32)
    # vcxproj Debug cikti adi: db_d.exe
    set_target_properties(db PROPERTIES DEBUG_POSTFIX "_d")
    # libmysql.dll calisma dizinine kopyala
    if(EXISTS "${EXTERN_DLL_DIR}/libmysql.dll")
        add_custom_command(TARGET db POST_BUILD
            COMMAND "${CMAKE_COMMAND}" -E copy_if_different
                    "${EXTERN_DLL_DIR}/libmysql.dll" "$<TARGET_FILE_DIR:db>")
    endif()
elseif(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
    # Makefile: -fno-rtti -fno-exceptions + surum tanimlari
    target_compile_options(db PRIVATE -fno-rtti -fno-exceptions)
    target_compile_definitions(db PRIVATE
        __DB_VERSION__="${SERVER_REVISION}"
        __HOSTNAME__="${SERVER_HOSTNAME}"
        __PWD__="${CMAKE_BINARY_DIR}"
        __USER__="${SERVER_BUILD_USER}")
    target_link_libraries(db PRIVATE
        "${MYSQLCLIENT_LIB}" ${SERVER_SSL_LIBS} ${Z_LIB} m)
    # FreeBSD'de cikti uzantisiz: db
endif()
