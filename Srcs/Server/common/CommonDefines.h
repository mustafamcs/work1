#ifndef __INC_METIN2_COMMON_DEFINES_H__
#define __INC_METIN2_COMMON_DEFINES_H__
#pragma once
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
// ### New Features ###
#define ENABLE_NO_MOUNT_CHECK
#define ENABLE_D_NJGUILD
#define ENABLE_FULL_NOTICE
#define ENABLE_NEWSTUFF
#define ENABLE_PORT_SECURITY
#define ENABLE_BELT_INVENTORY_EX
#define ENABLE_CMD_WARP_IN_DUNGEON
// #define ENABLE_ITEM_ATTR_COSTUME
// #define ENABLE_SEQUENCE_SYSTEM
// Karakter yuvası 4. pid5 açılmaz.
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
// Eldiven üç profilde de yok.
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
// ### Ex Features ###
#define DISABLE_STOP_RIDING_WHEN_DIE //	if DISABLE_TOP_RIDING_WHEN_DIE is defined, the player doesn't lose the horse after dying
#define ENABLE_ACCE_COSTUME_SYSTEM //fixed version
// #define USE_ACCE_ABSORB_WITH_NO_NEGATIVE_BONUS //enable only positive bonus in acce absorb
#define ENABLE_HIGHLIGHT_NEW_ITEM //if you want to see highlighted a new item when dropped or when exchanged
#define ENABLE_KILL_EVENT_FIX //if you want to fix the 0 exp problem about the when kill lua event (recommended)
// #define ENABLE_SYSLOG_PACKET_SENT // debug purposes

#define ENABLE_EXTEND_ITEM_AWARD //slight adjustement
#ifdef ENABLE_EXTEND_ITEM_AWARD
	// #define USE_ITEM_AWARD_CHECK_ATTRIBUTES //it prevents bonuses higher than item_attr lvl1-lvl5 min-max range limit
#endif

// Won / cheque yok. Yang bigint. İkinci para kolonu açılmaz.
// #define ENABLE_CHEQUE_SYSTEM
#ifdef ENABLE_CHEQUE_SYSTEM
#define ENABLE_SHOP_USE_CHEQUE
#define DISABLE_CHEQUE_DROP
#define ENABLE_WON_EXCHANGE_WINDOW
#endif
// ### END Ex Features ###
//////////////////////////////////////////////////////////////////////////

#define ENABLE_TARGET_INFORMATION_SYSTEM					// Mop Drop İnfo

#define FULL_YANG // Enable support for yang type long long

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


//////////////////////////////////////////////////////////////////////////
// ### Daginik Dosyalardan Toplanan Ayarlar ###
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

// ### Hic Tanimlanmamis Kapali Ozellikler (envanter) ###
// #define ENABLE_ACCE_SYSTEM                         // Server/game/src/ikarus_shop_manager.cpp
// #define ENABLE_CHANGELOOK_SYSTEM                   // Client/UserInterface/PythonIkarusShop.h, Server/db/src/ClientManagerIkarusShop.cpp, Server/db/src/IkarusShopCache.cpp
// #define ENABLE_GOOGLE_TEST                         // Server/game/src/main.cpp
// #define ENABLE_HACK_TELEPORT_LOG                   // Server/game/src/input_main.cpp
// #define ENABLE_IKASHOP_LOGS                        // Server/db/src/ClientManager.h, Server/db/src/ClientManagerIkarusShop.cpp, Server/db/src/IkarusShopCache.cpp
// #define ENABLE_ITEM_COUNT_LIMIT_SYSTEM             // Client/UserInterface/Packet.h, Server/game/src/packet.h
// #define ENABLE_MONARCH_MOB_CMD_MAP_CHECK           // Server/game/src/cmd_general.cpp
// #define ENABLE_OFFLINESHOP_DEBUG                   // Server/db/src/ClientManagerIkarusShop.cpp
// #define ENABLE_SASH_SYSTEM                         // Server/game/src/ikarus_shop_manager.cpp
// #define ENABLE_SOULBIND_SYSTEM                     // Client/GameLib/ItemData.h, Client/UserInterface/PythonApplicationModule.cpp, Server/game/src/ikarus_shop_manager.cpp
// #define USE_STACKTRACE                             // Server/game/src/main.cpp
#endif




