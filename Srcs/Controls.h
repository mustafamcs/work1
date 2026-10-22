#ifndef __INC_METIN2_CONTROLS_H__
#define __INC_METIN2_CONTROLS_H__
#pragma once

// =========================================================================
// Controls.h — ORTAK AYAR DOSYASI (client + server)
// Tum sistem ayarlari/defineleri yalnizca bu dosyadan yonetilir.
// Aktif : #define X  veya  #define X <deger>
// Kapali: // #define X
// Eski dosyalar: Client/UserInterface/Locale_inc.h ve Server/common/CommonDefines.h
// bu dosyada birlestirildi ve kaldirildi.
// =========================================================================

//////////////////////////////////////////////////////////////////////////
// ### Default Ymir Macros (client) ###
#define LOCALE_SERVICE_EUROPE
#define ENABLE_COSTUME_SYSTEM
#define ENABLE_ENERGY_SYSTEM
#define ENABLE_DRAGON_SOUL_SYSTEM
#define ENABLE_NEW_EQUIPMENT_SYSTEM
// ### Default Ymir Macros ###
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Standard Features ###
//#define _IMPROVED_PACKET_ENCRYPTION_
#ifdef _IMPROVED_PACKET_ENCRYPTION_
#define USE_IMPROVED_PACKET_DECRYPTED_BUFFER
#endif
#define __UDP_BLOCK__
//#define ENABLE_QUEST_CATEGORY
// ### END Standard Features ###
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Ortak / New Features (client + server) ###
#define ENABLE_NO_MOUNT_CHECK
#define ENABLE_D_NJGUILD
#define ENABLE_FULL_NOTICE
#define ENABLE_NEWSTUFF
#define ENABLE_PORT_SECURITY
#define ENABLE_BELT_INVENTORY_EX
#define ENABLE_CMD_WARP_IN_DUNGEON
// #define ENABLE_ITEM_ATTR_COSTUME
// #define ENABLE_SEQUENCE_SYSTEM
// Karakter yuvasi 4. pid5 acilmaz.
// #define ENABLE_PLAYER_PER_ACCOUNT5
#define ENABLE_DICE_SYSTEM
#define ENABLE_DS_GRADE_MYTH
#define ENABLE_EXTEND_INVEN_SYSTEM
#define ENABLE_MOUNT_COSTUME_SYSTEM
#define ENABLE_WEAPON_COSTUME_SYSTEM
#define ENABLE_QUEST_DIE_EVENT
#define ENABLE_QUEST_BOOT_EVENT
#define ENABLE_QUEST_DND_EVENT
#define ENABLE_PET_SYSTEM_EX
#define ENABLE_SKILL_FLAG_PARTY
#define ENABLE_NO_DSS_QUALIFICATION
// #define ENABLE_NO_SELL_PRICE_DIVIDED_BY_5
#define ENABLE_CHECK_SELL_PRICE
#define ENABLE_GOTO_LAG_FIX
#define ENABLE_MOUNT_COSTUME_EX_SYSTEM
#define ENABLE_PENDANT_SYSTEM
// Eldiven uc profilde de yok.
// #define ENABLE_GLOVE_SYSTEM
#define ENABLE_MOVE_CHANNEL
#define ENABLE_QUIVER_SYSTEM
#define ENABLE_REDUCED_ENTITY_VIEW
#define ENABLE_GUILD_TOKEN_AUTH
#define ENABLE_DB_SQL_LOG

#define __PET_SYSTEM__
#ifdef __PET_SYSTEM__
#define USE_ACTIVE_PET_SEAL_EFFECT
#define PET_SEAL_ACTIVE_SOCKET_IDX 2
#define USE_PET_SEAL_ON_LOGIN
#endif

enum eCommonDefines {
	MAP_ALLOW_LIMIT = 32, // 32 default
};

//#define ENABLE_WOLFMAN_CHARACTER
//#ifdef ENABLE_WOLFMAN_CHARACTER
// #define DISABLE_WOLFMAN_ON_CREATE
//#define USE_MOB_BLEEDING_AS_POISON
//#define USE_MOB_CLAW_AS_DAGGER
// #define USE_ITEM_BLEEDING_AS_POISON
// #define USE_ITEM_CLAW_AS_DAGGER
//#define USE_WOLFMAN_STONES
//#define USE_WOLFMAN_BOOKS
//#endif

// #define ENABLE_MAGIC_REDUCTION_SYSTEM
#ifdef ENABLE_MAGIC_REDUCTION_SYSTEM
// #define USE_MAGIC_REDUCTION_STONES
#endif
// ### END New Features ###
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Client Ozellikleri (New From LocaleInc) ###
#define ENABLE_PACK_GET_CHECK
#define ENABLE_CANSEEHIDDENTHING_FOR_GM
#define ENABLE_PROTOSTRUCT_AUTODETECT
#define ENABLE_LEVEL_IN_TRADE
#define ENABLE_LVL115_ARMOR_EFFECT
#define ENABLE_SLOT_WINDOW_EX
#define ENABLE_TEXT_LEVEL_REFRESH
#define ENABLE_USE_COSTUME_ATTR
#define ENABLE_DISCORD_RPC
#define ENABLE_LOCALE_EX
#define ENABLE_RACE_HEIGHT
#define ENABLE_ELEMENTAL_TARGET
#define ENABLE_INGAME_CONSOLE
#define ENABLE_4TH_AFF_SKILL_DESC
#define ENABLE_LOCALE_COMMON
#define ENABLE_CONQUEROR_UI

#define ENABLE_NEW_EVENT_STRUCT
#ifdef ENABLE_NEW_EVENT_STRUCT
#define USE_NEW_EVENT_TEXT_AUTO_Y
#endif

#define WJ_SHOW_MOB_INFO
#ifdef WJ_SHOW_MOB_INFO
#define ENABLE_SHOW_MOBAIFLAG
#define ENABLE_SHOW_MOBLEVEL
#define WJ_SHOW_MOB_INFO_EX
#endif
// ### New From LocaleInc ###
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Ex / Extended Features (ortak) ###
#define DISABLE_STOP_RIDING_WHEN_DIE //	if DISABLE_TOP_RIDING_WHEN_DIE is defined, the player doesn't lose the horse after dying
#define ENABLE_ACCE_COSTUME_SYSTEM //fixed version
#ifdef ENABLE_ACCE_COSTUME_SYSTEM
// #define USE_ACCE_ABSORB_WITH_NO_NEGATIVE_BONUS //enable only positive bonus in acce absorb
#endif
// if you want use SetMouseWheelScrollEvent or you want use mouse wheel to move the scrollbar
#define ENABLE_MOUSEWHEEL_EVENT
// if you want to see highlighted a new item when dropped or when exchanged
#define ENABLE_HIGHLIGHT_NEW_ITEM
// it shows emojis in the textlines
#define ENABLE_EMOJI_SYSTEM
// effects while hidden won't show up
#define __ENABLE_STEALTH_FIX__
// circle dots in minimap instead of squares
#define ENABLE_MINIMAP_WHITEMARK_CIRCLE
#define ENABLE_MINIMAP_TELEPORT_CLICK // click on minimap as gm to warp directly
#define ENABLE_KILL_EVENT_FIX //if you want to fix the 0 exp problem about the when kill lua event (recommended)
// #define ENABLE_SYSLOG_PACKET_SENT // debug purposes

#define ENABLE_EXTEND_ITEM_AWARD //slight adjustement
#ifdef ENABLE_EXTEND_ITEM_AWARD
	// #define USE_ITEM_AWARD_CHECK_ATTRIBUTES //it prevents bonuses higher than item_attr lvl1-lvl5 min-max range limit
#endif

// Won / cheque yok. Yang bigint. Ikinci para kolonu acilmaz. (server karari; client eskiden acikti)
// #define ENABLE_CHEQUE_SYSTEM
#ifdef ENABLE_CHEQUE_SYSTEM
#define ENABLE_SHOP_USE_CHEQUE
#define DISABLE_CHEQUE_DROP
#define ENABLE_WON_EXCHANGE_WINDOW
#endif
// ### END Ex Features ###
//////////////////////////////////////////////////////////////////////////

#define ENABLE_TARGET_INFORMATION_SYSTEM					// Mop Drop Info / Mob info

#define FULL_YANG // Enable support for yang type long long (server tarafi)
#define ENABLE_FULL_YANG // client tarafi

#define __BL_CLIENT_LOCALE_STRING__
#define __BL_MULTI_LANGUAGE__
#define __BL_MULTI_LANGUAGE_PREMIUM__
#define __BL_MULTI_LANGUAGE_ULTIMATE__
#define ENABLE_GF_ATLAS_MARK_INFO // https://metin2.dev/topic/23474-gf-loadatlasmarkinfo/

#define ENABLE_IKASHOP_RENEWAL
#define EXTEND_IKASHOP_PRO
#define EXTEND_IKASHOP_ULTIMATE
#define ENABLE_LARGE_DYNAMIC_PACKETS
#define ENABLE_IKASHOP_ENTITIES

// for debug: print received packets
// #define ENABLE_PRINT_RECV_PACKET_DEBUG

//////////////////////////////////////////////////////////////////////////
// ### Daginik Dosyalardan Toplanan Ayarlar (client) ###
// <Client/EterBase/error.cpp>
#define ENABLE_CRASH_MINIDUMP
// <Client/EterLib/lineintersect_utils.cpp>
//#define USE_CRAMERS_RULE
// <Client/EterPack/EterPack.cpp>
#define ENABLE_CRC32_CHECK
// <Client/GameLib/ActorInstance.h>
#define ENABLE_HAIR_SPECULAR
// <Client/GameLib/ActorInstanceCollisionDetection.cpp>
#define ENABLE_NPC_WITHOUT_COLLISIONS
// <Client/GameLib/ActorInstanceCollisionDetection.cpp>
#ifndef ENABLE_NPC_WITHOUT_COLLISIONS
#define ENABLE_PETS_WITHOUT_COLLISIONS
#define ENABLE_SHOPS_WITHOUT_COLLISIONS
#define ENABLE_MOUNTS_WITHOUT_COLLISIONS
#endif
// <Client/GameLib/ActorInstanceMotion.cpp>
#define ENABLE_WALK_RUN_ANI_ALTERNATIVE
// <Client/GameLib/ItemData.cpp>
#define ENABLE_LOAD_ALTER_ITEMICON
// <Client/GameLib/MapOutdoor.cpp>
//#define USE_LEVEL
// <Client/GameLib/MapOutdoor.cpp>
// #define ENABLE_FOG_LOAD
// <Client/GameLib/RaceDataFile.cpp>
#define ENABLE_SKIN_EXTENDED
// <Client/SpeedTreeLib/Constants.h>
// #define USE_SPEEDGRASS   // Constants.h hicbir yerde include edilmiyor - orijinalde kapaliydi
// <Client/UserInterface/InstanceBase.cpp>
// #define ENABLE_SIMPLE_REFINED_EFFECT_CHECK
// <Client/UserInterface/InstanceBase.cpp>
// #define USE_WEAPON_COSTUME_WITH_EFFECT
// <Client/UserInterface/InstanceBase.cpp>
// #define USE_BODY_COSTUME_WITH_EFFECT
// <Client/UserInterface/PythonApplication.cpp>
#define ENABLE_LOAD_ITEM_LIST_FROM_ROOT
// <Client/UserInterface/PythonApplication.cpp>
#define ENABLE_LOAD_ITEM_SCALE_FROM_ROOT
// <Client/UserInterface/PythonApplication.cpp>
#define ENABLE_LOAD_SKILL_TABLE_FROM_ROOT
// <Client/UserInterface/PythonBackground.cpp>
#define ENABLE_ATLASINFO_FROM_ROOT
// <Client/UserInterface/PythonNonPlayer.h>
// #define ENABLE_NEW_MOB_PROTO_STRUCT_20141125	// bleeding resistance 2014/11/25
// <Client/UserInterface/PythonNonPlayer.h>
// #define ENABLE_NEW_MOB_PROTO_STRUCT_20151020	// claw resistance 2015/10/20
// <Client/UserInterface/PythonPlayer.cpp>
#define ENABLE_NO_PICKUP_LIMIT
// <Client/UserInterface/UserInterface.cpp>
#define ENABLE_PYLIB_CHECK
// <Client/UserInterface/UserInterface.cpp>
#define ENABLE_MILES_CHECK
// <Client/UserInterface/UserInterface.cpp>
// #define ENABLE_DAEMONPROTECTION

//////////////////////////////////////////////////////////////////////////
// ### Daginik Dosyalardan Toplanan Ayarlar (server) ###
// <Server/db/src/ClientManager.cpp>
#define ENABLE_DEFAULT_PRIV
// <Server/db/src/ClientManager.cpp>
#define ENABLE_ITEMAWARD_REFRESH
// <Server/db/src/ClientManager.h>
#define ENABLE_PROTO_FROM_DB
// <Server/db/src/ClientManagerBoot.cpp>
#ifdef ENABLE_PROTO_FROM_DB
#define ENABLE_AUTODETECT_VNUMRANGE
#endif
// <Server/db/src/ProtoReader.cpp>
#define ENABLE_NUMERIC_FIELD
// <Server/game/src/char.cpp>
// #define ENABLE_SHOWNPCLEVEL
// <Server/game/src/char.cpp>
#define ENABLE_GM_FLAG_IF_TEST_SERVER
// <Server/game/src/char.cpp>
#define ENABLE_GM_FLAG_FOR_LOW_WIZARD
// <Server/game/src/char.cpp>
#define ENABLE_GOHOME_IF_MAP_NOT_ALLOWED
// <Server/game/src/char.cpp>
// #define ENABLE_MOUNT_ENTITY_REFRESH
// <Server/game/src/char.h>
// #define ENABLE_ANTI_CMD_FLOOD
// <Server/game/src/char.h>
#define ENABLE_OPEN_SHOP_WITH_ARMOR
// <Server/game/src/char.h>
#define ENABLE_SKILL_COOLDOWN_CHECK
// <Server/game/src/char_battle.cpp>
#define ENABLE_EFFECT_PENETRATE
// <Server/game/src/char_battle.cpp>
#define ENABLE_NEWEXP_CALCULATION
// <Server/game/src/char_battle.cpp>
// #define ENABLE_NO_DAMAGE_QUEST_RUNNING
// <Server/game/src/char_item.cpp>
#define ENABLE_EFFECT_EXTRAPOT
// <Server/game/src/char_item.cpp>
#define ENABLE_BOOKS_STACKFIX
// <Server/game/src/char_item.cpp>
#define ENABLE_ITEM_RARE_ATTR_LEVEL_PCT
// <Server/game/src/char_item.cpp>
#define ENABLE_UNIQUE_ITEM_AUTOSPLIT
// <Server/game/src/char_item.cpp>
// #define ENABLE_FIREWORK_STUN
// <Server/game/src/char_item.cpp>
#define ENABLE_ADDSTONE_FAILURE
// <Server/game/src/char_resist.cpp>
// #define ENABLE_IMMUNE_PERC
// <Server/game/src/char_skill.cpp>
#define ENABLE_FORCE2MASTERSKILL
// <Server/game/src/char_skill.cpp>
// #define ENABLE_NULLIFYAFFECT_LIMIT
// <Server/game/src/char_skill.cpp>
// #define ENABLE_MASTER_SKILLBOOK_NO_STEPS
// <Server/game/src/cmd.cpp>
// #define ENABLE_BLOCK_CMD_SHORTCUT
// <Server/game/src/cmd_gm.cpp>
#define ENABLE_CMD_IPURGE_EX
// <Server/game/src/cmd_gm.cpp>
#define ENABLE_SET_STATE_WITH_TARGET
// <Server/game/src/cmd_gm.cpp>
#define ENABLE_STATPLUS_NOLIMIT
// <Server/game/src/config.cpp>
#define ENABLE_AUTODETECT_INTERNAL_IP
// <Server/game/src/config.cpp>
#define ENABLE_CMD_PLAYER
// <Server/game/src/config.cpp>
#define ENABLE_EXPTABLE_FROMDB
// <Server/game/src/config.cpp>
// #define ENABLE_GENERAL_CMD
// <Server/game/src/config.cpp>
// #define ENABLE_GENERAL_CONFIG
// <Server/game/src/db.cpp>
// #define ENABLE_SPAMDB_REFRESH
// <Server/game/src/debug_allocator.h>
// #define DEBUG_ALLOC                  // debug allocator/DebugPtr sistemi (acinca USE_DEBUG_PTR otomatik gelir)
// <Server/game/src/fishing.cpp>
#define ENABLE_FISHINGROD_RENEWAL
// <Server/game/src/guild.cpp>
#define ENABLE_GUILD_COMMENT_ANTIFLOOD
// <Server/game/src/guild.h>
// #define ENABLE_NEWGUILDMAKE
// <Server/game/src/horse_rider.h>
// #define ENABLE_INFINITE_HORSE_HEALTH_STAMINA
// <Server/game/src/ikarus_shop_manager.cpp>
// #define ENABLE_IKASHOP_GM_PROTECTION
// <Server/game/src/input_auth.cpp>
// #define ENABLE_ACCOUNT_W_SPECIALCHARS
// <Server/game/src/input_db.cpp>
#define ENABLE_GOHOME_IF_MAP_NOT_EXIST
// <Server/game/src/input_login.cpp>
// #define USE_LYCAN_CREATE_POSITION
// <Server/game/src/input_main.cpp>
#define ENABLE_CHAT_COLOR_SYSTEM
// <Server/game/src/input_main.cpp>
#define ENABLE_CHAT_LOGGING
// <Server/game/src/input_main.cpp>
#define ENABLE_CHAT_SPAMLIMIT
// <Server/game/src/input_main.cpp>
#define ENABLE_WHISPER_CHAT_SPAMLIMIT
// <Server/game/src/input_main.cpp>
#define ENABLE_CHECK_GHOSTMODE
// <Server/game/src/input_main.cpp>
		// #define ENABLE_TP_SPEED_CHECK
// <Server/game/src/item.cpp>
#define ENABLE_IMMUNE_FIX
// <Server/game/src/item_manager.h>
#define ENABLE_ITEM_PROTO_MAP
// <Server/game/src/limit_time.h>
//#define ENABLE_LIMIT_TIME
// <Server/game/src/mining.cpp>
#define ENABLE_PICKAXE_RENEWAL
// <Server/game/src/questlua.cpp>
#define ENABLE_TRANSLATE_LUA
// <Server/game/src/questlua_pc.cpp>
// #define ENABLE_LOCALECHECK_CHANGENAME
// <Server/game/src/questlua_pc.cpp>
// #define ENABLE_PC_OPENSHOP
// <Server/game/src/questmanager.cpp>
#define ENABLE_PARTYKILL
// <Server/game/src/shop.cpp>
//#define ENABLE_SHOP_BLACKLIST

//////////////////////////////////////////////////////////////////////////
// ### Pack/Python Ayarlari (client) ###
// Buradaki tum tanimlar derleme sirasinda app.X olarak python'a aktarilir.
// Aktif: #define X / #define X <deger>   Kapali: // #define X

// #define ENABLE_NEW_LEVELSKILL_SYSTEM    // 5 (B,M,G,P,F) beceri .mse yukler
// #define ENABLE_RANDOM_CHANNEL_SEL       // istemci acilisinda rastgele kanal
// #define ENABLE_CLEAN_DATA_IF_FAIL_LOGIN // basarisiz giriste id/sifre silme
#define ENABLE_PASTE_FEATURE              // ctrl+v aktif
#define ENABLE_FULLSTONE_DETAILS          // tasin tum bonuslarini goster
// #define ENABLE_REFINE_PCT               // refine diyalogunda basari yuzdesi
#define EXTRA_UI_FEATURE                  // ekstra ui ozellikleri
#define NEW_678TH_SKILL_ENABLE            // 6. savasci/ninja becerileri
#define SELECT_CHAR_NO_DELAY 0.5          // karakter secim bekleme suresi
#define ENABLE_ACTIVE_PET_SEAL_EFFECT     // pet muhru aktif efekti
// #define ENABLE_RECURSIVE_UI_DESTROY     // ui bilesenlerini zorla temizle
#define ENABLE_CMDCHAT_VARIADIC_ARGS      // cmdchat degisken arguman
#define ENABLE_SELF_STACK_SCROLLS         // scroll kendinden stack
#define ENABLE_SAVE_ACCOUNT               // hesap kaydetme
#define ENABLE_ENGNUM_DELETE_CODE         // karakter silme kodu sayisal
#define ENABLE_CHAT_COMMAND               // sohbet komutlari
#define ENABLE_LAST_SENTENCE_STACK        // son sohbet satiri stack
#define ENABLE_INSULT_CHECK               // kufur kontrolu
// #define DISABLE_GUILD_SKILL             // lonca becerisi kapali
// #define DISABLE_DECLARE_WAR             // savas ilani kapali
// #define ENABLE_HELP_MULTIPAGE           // yardim cok sayfali
#define ENABLE_DEFAULT_UI_BOARD 1         // ikarus shop varsayilan board
#define ITEM_MALL_BUTTON_ENABLE           // envanter item mall butonu
// #define LEAVE_BUTTON_FOR_POTAL          // portaldan ayrilma butonu
// #define NOT_NEED_DELETE_CODE            // silme kodu gerekmesin
#define SCREENSHOT_CWDSAVE                // ekran goruntusu cwd kaydet
// #define SKIP_LOGIN_PHASE                // login asamasini atla
// #define SKIP_LOGIN_PHASE_SUPPORT_CHANNEL
// #define FULL_BACK_IMAGE                 // login tam ekran arkaplan
#define VIRTUAL_KEYBOARD_RAND_KEY         // sanal klavye karisik tus
#define LOGIN_DELAY_SEC 0.0f              // login gecikme suresi
#define VIRTUAL_KEYBOARD_NUM_KEYS 46      // sanal klavye tus sayisi
// #define SHOW_ONLY_ACTIVE_SKILL          // sadece aktif beceriler
#define HIDE_SUPPORT_SKILL_POINT          // destek beceri puani gizle
// #define SYSTEM_MENU_FOR_PORTAL          // sistem menusu portal

// --- Degerli ayarlar (python'a aynen aktarilir; kapatmak icin silme, degeri degistir) ---
#define IN_GAME_SHOP_ENABLE 1
#define CONSOLE_ENABLE 0
#define PVPMODE_ENABLE 1
#define PVPMODE_TEST_ENABLE 0
#define PVPMODE_ACCELKEY_ENABLE 1
#define PVPMODE_ACCELKEY_DELAY 0.5f
#define PVPMODE_PROTECTED_LEVEL 15
#define FOG_LEVEL0 4800.0f
#define FOG_LEVEL1 9600.0f
#define FOG_LEVEL2 12800.0f
#define CAMERA_MAX_DISTANCE_SHORT 2500.0f
#define CAMERA_MAX_DISTANCE_LONG 3500.0f
#define CHRNAME_COLOR_INDEX 0
#define ENVIRONMENT_NIGHT "d:/ymir work/environment/moonlight04.msenv"
#define HIGH_PRICE 500000
#define MIDDLE_PRICE 50000
#define ERROR_METIN_STONE 28960
#define SUB2_LOADING_ENABLE 1
#define EXPANDED_COMBO_ENABLE 1
#define CONVERT_EMPIRE_LANGUAGE_ENABLE 0
#define USE_ITEM_WEAPON_TABLE_ATTACK_BONUS 0
#define ADD_DEF_BONUS_ENABLE 0
#define LOGIN_COUNT_LIMIT_ENABLE 0
#define USE_SKILL_EFFECT_UPGRADE_ENABLE 1
#define VIEW_OTHER_EMPIRE_PLAYER_TARGET_BOARD 1
#define GUILD_MONEY_PER_GSP 100
#define GUILD_WAR_TYPE_SELECT_ENABLE 1
#define TWO_HANDED_WEAPON_ATT_SPEED_DECREASE_VALUE 10
#define DEFAULT_HAIR_COLOR_ENABLE 1       // HAIR_COLOR_ENABLE C++ global ile cakisiyor - py'ya HAIR_COLOR_ENABLE olarak aktarilir
#define ARMOR_SPECULAR_ENABLE 1
#define WEAPON_SPECULAR_ENABLE 1
#define SEQUENCE_PACKET_ENABLE 1
#define KEEP_ACCOUNT_CONNETION_ENABLE 1
#define MINIMAP_POSITIONINFO_ENABLE 1

//////////////////////////////////////////////////////////////////////////
// ### Hic Tanimlanmamis Kapali Ozellikler (envanter, client+server) ###
// #define ENABLE_678TH_SKILL                         // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_ACCE_SYSTEM                         // Server/game/src/ikarus_shop_manager.cpp
// #define ENABLE_AURA_COSTUME_SYSTEM                 // Client/GameLib/ItemManager.cpp
// #define ENABLE_AUTO_L2R                            // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_AUTO_SYSTEM                         // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_CHANGELOOK_SYSTEM                   // Client/UserInterface/PythonIkarusShop.h, Server/db/src/ClientManagerIkarusShop.cpp, Server/db/src/IkarusShopCache.cpp
// #define ENABLE_CONQUEROR_LEVEL                     // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_DISCORD_JOIN_URL                    // Client/UserInterface/PythonNetworkStreamPhaseGame.cpp
// #define ENABLE_ENVIRONMENT_EFFECT_OPTION           // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_GOLD_FIELD_AS_SELL_PRICE            // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_GOOGLE_TEST                         // Server/game/src/main.cpp
// #define ENABLE_GROWTH_PET_SYSTEM                   // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_HACK_TELEPORT_LOG                   // Server/game/src/input_main.cpp
// #define ENABLE_HELP_RENEWAL                        // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_IKASHOP_LOGS                        // Server/db/src/ClientManager.h, Server/db/src/ClientManagerIkarusShop.cpp, Server/db/src/IkarusShopCache.cpp
// #define ENABLE_ITEM_COUNT_LIMIT_SYSTEM             // Client/UserInterface/Packet.h, Server/game/src/packet.h
// #define ENABLE_MONARCH_MOB_CMD_MAP_CHECK           // Server/game/src/cmd_general.cpp
// #define ENABLE_MONSTER_CARD                        // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_OFFLINESHOP_DEBUG                   // Server/db/src/ClientManagerIkarusShop.cpp
// #define ENABLE_PLAYER_CHECKAFFECT                  // Client/UserInterface/PythonPlayerModule.cpp
// #define ENABLE_PREMIUM_LOOT_FILTER                 // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_SASH_SYSTEM                         // Server/game/src/ikarus_shop_manager.cpp
// #define ENABLE_SEALBIND_SYSTEM                     // Client/UserInterface/PythonItemModule.cpp, Client/UserInterface/PythonPlayerModule.cpp
// #define ENABLE_SOULBIND_SYSTEM                     // Client/GameLib/ItemData.h, Client/UserInterface/PythonApplicationModule.cpp, Server/game/src/ikarus_shop_manager.cpp
// #define ENABLE_UI_CIRCLE                           // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_UI_MOVING                           // Client/UserInterface/PythonApplicationModule.cpp
// #define USE_STACKTRACE                             // Server/game/src/main.cpp
// #define ENABLE_DRAGON_GATE                         // Pack/locale ui scriptleri (app.X sorgusu)
// #define ENABLE_MERCENARY_SYSTEM                    // Pack/locale ui scriptleri (app.X sorgusu)
// #define ENABLE_SUNGMAHEE_GATE                      // Pack/locale ui scriptleri (app.X sorgusu)
// #define ENABLE_ADDITIONAL_EQUIPMENT_PAGE           // Pack/locale ui scriptleri (app.X sorgusu)
// #define ENABLE_SERVER_SELECT_RENEWAL               // Pack/locale ui scriptleri (app.X sorgusu)
// #define ENABLE_PREMIUM_PRIVATE_SHOP                // Pack/locale ui scriptleri (app.X sorgusu)
// #define LOCALE_SERVICE_GLOBAL                      // Client/UserInterface/Locale.cpp
// #define LOCALE_SERVICE_JAPAN                       // Client/UserInterface/StdAfx.h
// #define LOCALE_SERVICE_STAGE_DEVELOPMENT           // Client/UserInterface/PythonApplicationModule.cpp
// #define LOCALE_SERVICE_STAGE_TEST                  // Client/UserInterface/PythonApplicationModule.cpp
// #define LOCALE_SERVICE_VIETNAM_MILD                // Client/UserInterface/UserInterface.cpp
// #define LOCALE_SERVICE_WE_JAPAN                    // Client/UserInterface/Locale.cpp, Client/UserInterface/PythonSystem.cpp
// #define LOCALE_SERVICE_YMIR                        // Client/UserInterface/UserInterface.cpp
// #define USE_OPENID                                 // Client/UserInterface/PythonApplicationModule.cpp
// #define USE_RELATIVE_PATH                          // Client/UserInterface/UserInterface.cpp
// #define __BL_CLIP_MASK__                           // Client/UserInterface/PythonApplicationModule.cpp, Client/UserInterface/PythonChat.cpp
// #define __BL_MOUSE_WHEEL_TOP_WINDOW__              // Client/UserInterface/PythonApplicationModule.cpp
// #define __BL_OFFICIAL_LOOT_FILTER__                // Client/UserInterface/PythonApplicationModule.cpp

#endif // __INC_METIN2_CONTROLS_H__
