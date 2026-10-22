# game — oyun sunucusu (game.vcxproj ClCompile listesi ile ayni, 155 kaynak)
# + qc — quest compiler (qc.vcxproj: src/quest altindaki 2 kaynak)
set(GAME_SOURCES
    src/affect.cpp
    src/ani.cpp
    src/arena.cpp
    src/banword.cpp
    src/battle.cpp
    src/blend_item.cpp
    src/BlueDragon.cpp
    src/BlueDragon_Binder.cpp
    src/buff_on_attributes.cpp
    src/buffer_manager.cpp
    src/building.cpp
    src/castle.cpp
    src/char.cpp
    src/char_affect.cpp
    src/char_battle.cpp
    src/char_change_empire.cpp
    src/char_dragonsoul.cpp
    src/char_horse.cpp
    src/char_item.cpp
    src/char_manager.cpp
    src/char_quickslot.cpp
    src/char_resist.cpp
    src/char_skill.cpp
    src/char_state.cpp
    src/cipher.cpp
    src/ClientPackageCryptInfo.cpp
    src/cmd.cpp
    src/cmd_emotion.cpp
    src/cmd_general.cpp
    src/cmd_gm.cpp
    src/cmd_oxevent.cpp
    src/config.cpp
    src/constants.cpp
    src/crc32.cpp
    src/cube.cpp
    src/db.cpp
    src/desc.cpp
    src/desc_client.cpp
    src/desc_manager.cpp
    src/desc_p2p.cpp
    src/dragon_soul_table.cpp
    src/DragonLair.cpp
    src/DragonSoul.cpp
    src/dungeon.cpp
    src/empire_text_convert.cpp
    src/entity.cpp
    src/entity_view.cpp
    src/event.cpp
    src/event_queue.cpp
    src/exchange.cpp
    src/file_loader.cpp
    src/fishing.cpp
    src/FSM.cpp
    src/gm.cpp
    src/group_text_parse_tree.cpp
    src/guild.cpp
    src/guild_manager.cpp
    src/guild_war.cpp
    src/horse_rider.cpp
    src/horsename_manager.cpp
    src/ikarus_shop.cpp
    src/ikarus_shop_manager.cpp
    src/ikarus_shop_safebox.cpp
    src/input.cpp
    src/input_auth.cpp
    src/input_db.cpp
    src/input_login.cpp
    src/input_main.cpp
    src/input_p2p.cpp
    src/input_udp.cpp
    src/item.cpp
    src/item_addon.cpp
    src/item_attribute.cpp
    src/item_manager.cpp
    src/item_manager_idrange.cpp
    src/item_manager_read_tables.cpp
    src/locale.cpp
    src/locale_service.cpp
    src/log.cpp
    src/login_data.cpp
    src/lzo_manager.cpp
    src/main.cpp
    src/map_location.cpp
    src/MarkConvert.cpp
    src/MarkImage.cpp
    src/MarkManager.cpp
    src/marriage.cpp
    src/messenger_manager.cpp
    src/minilzo.c
    src/mining.cpp
    src/mob_manager.cpp
    src/monarch.cpp
    src/motion.cpp
    src/over9refine.cpp
    src/OXEvent.cpp
    src/p2p.cpp
    src/packet_info.cpp
    src/panama.cpp
    src/party.cpp
    src/PetSystem.cpp
    src/polymorph.cpp
    src/priv_manager.cpp
    src/pvp.cpp
    src/questevent.cpp
    src/questlua.cpp
    src/questlua_affect.cpp
    src/questlua_arena.cpp
    src/questlua_building.cpp
    src/questlua_danceevent.cpp
    src/questlua_dnd.cpp
    src/questlua_dragonlair.cpp
    src/questlua_dragonsoul.cpp
    src/questlua_dungeon.cpp
    src/questlua_forked.cpp
    src/questlua_game.cpp
    src/questlua_global.cpp
    src/questlua_guild.cpp
    src/questlua_horse.cpp
    src/questlua_item.cpp
    src/questlua_marriage.cpp
    src/questlua_mgmt.cpp
    src/questlua_monarch.cpp
    src/questlua_npc.cpp
    src/questlua_oxevent.cpp
    src/questlua_party.cpp
    src/questlua_pc.cpp
    src/questlua_pet.cpp
    src/questlua_quest.cpp
    src/questlua_target.cpp
    src/questmanager.cpp
    src/questnpc.cpp
    src/questpc.cpp
    src/refine.cpp
    src/regen.cpp
    src/safebox.cpp
    src/sectree.cpp
    src/sectree_manager.cpp
    src/sequence.cpp
    src/shop.cpp
    src/shop_manager.cpp
    src/shopEx.cpp
    src/shutdown_manager.cpp
    src/skill.cpp
    src/skill_power.cpp
    src/sql_data.cpp
    src/start_position.cpp
    src/target.cpp
    src/text_file_loader.cpp
    src/threeway_war.cpp
    src/trigger.cpp
    src/utils.cpp
    src/vector.cpp
    src/version.cpp
    src/war_map.cpp
    src/wedding.cpp
    src/xmas_event.cpp)

if(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
    # FreeBSD Makefile'inda ek olarak derleniyor (vcxproj'de yok)
    list(APPEND GAME_SOURCES src/FileMonitor_FreeBSD.cpp)
endif()

add_executable(game ${GAME_SOURCES})

# vcxproj'deki ama agacta olmayan include yollari atlandi:
# libmysql/6.0.2/win32, libdevil, libxtrap/include, libserverkey,
# ../Extern/openssl/include (mysql/DevIL/cryptopp Extern/include altinda zaten var)
target_include_directories(game PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/src"
    "${PROJECT_SOURCE_DIR}/liblua/5.0/include"
    "${PROJECT_SOURCE_DIR}/libpoly"
    "${PROJECT_SOURCE_DIR}/libsql")
target_link_libraries(game PRIVATE
    server_base platform thecore sql poly lgame lua)

if(WIN32)
    # vcxproj AdditionalDependencies:
    # libmysql.lib ws2_32.lib DevIL.lib ILU.lib ILUT.lib cryptlib-Release.lib
    target_link_libraries(game PRIVATE
        "${EXTERN_MYSQL_LIB}"
        "${EXTERN_DEVIL_LIB}" "${EXTERN_ILU_LIB}" "${EXTERN_ILUT_LIB}"
        "${EXTERN_CRYPTOPP_LIB}"
        ws2_32)
    # vcxproj Debug cikti adi: game_d.exe
    set_target_properties(game PROPERTIES DEBUG_POSTFIX "_d")
    # gerekli DLL'leri cikti dizinine kopyala
    if(EXISTS "${EXTERN_DLL_DIR}/libmysql.dll")
        add_custom_command(TARGET game POST_BUILD
            COMMAND "${CMAKE_COMMAND}" -E copy_if_different
                    "${EXTERN_DLL_DIR}/libmysql.dll"
                    "${EXTERN_DLL_DIR}/DevIL.dll"
                    "${EXTERN_DLL_DIR}/ILU.dll"
                    "${EXTERN_DLL_DIR}/ILUT.dll"
                    "$<TARGET_FILE_DIR:game>")
    endif()
elseif(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
    # Makefile: -fexceptions -fno-strict-aliasing + surum tanimlari
    target_compile_options(game PRIVATE -fexceptions -fno-strict-aliasing)
    target_compile_definitions(game PRIVATE
        ENABLE_LUA_5_VERSION=1
        __GAME_VERSION__="${SERVER_REVISION}"
        __HOSTNAME__="${SERVER_HOSTNAME}"
        __PWD__="${CMAKE_BINARY_DIR}"
        __USER__="${SERVER_BUILD_USER}")
    target_link_libraries(game PRIVATE
        "${MYSQLCLIENT_LIB}"
        "${DEVIL_LIB}" "${CRYPTOPP_LIB}"
        ${SERVER_SSL_LIBS} ${Z_LIB} ${MD_LIB} m)
    # FreeBSD'de cikti uzantisiz: game
endif()

# ---------------------------------------------------------------------------
# qc — quest compiler (qc.vcxproj'deki ClCompile listesi aynen tasindi)
# Not: Srcs/Tools/dumpproto ile ilgisi yok; kaynaklar Server/game/src/quest'te.
# src/quest/create_conversion.cc ayri bir arac, vcxproj'de yer almiyor.
# ---------------------------------------------------------------------------
add_executable(qc
    src/quest/qc.cc
    src/quest/crc32.cc)
target_include_directories(qc PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/src/quest"
    "${PROJECT_SOURCE_DIR}/liblua/5.0/include"
    "${PROJECT_SOURCE_DIR}/liblua/5.0/src")
target_link_libraries(qc PRIVATE server_base lua)
if(CMAKE_SYSTEM_NAME STREQUAL "FreeBSD")
    target_link_libraries(qc PRIVATE m)
endif()
