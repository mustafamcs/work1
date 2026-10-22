#pragma once

//////////////////////////////////////////////////////////////////////////
// ### Default Ymir Macros ###
#define LOCALE_SERVICE_EUROPE
#define ENABLE_COSTUME_SYSTEM
#define ENABLE_ENERGY_SYSTEM
#define ENABLE_DRAGON_SOUL_SYSTEM
#define ENABLE_NEW_EQUIPMENT_SYSTEM
// ### Default Ymir Macros ###
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### New From LocaleInc ###
#define ENABLE_PACK_GET_CHECK
#define ENABLE_CANSEEHIDDENTHING_FOR_GM
#define ENABLE_PROTOSTRUCT_AUTODETECT
// Karakter yuvası 4. Sunucu ENABLE_PLAYER_PER_ACCOUNT5 kapalı.
//#define ENABLE_PLAYER_PER_ACCOUNT5
#define ENABLE_LEVEL_IN_TRADE
#define ENABLE_DICE_SYSTEM
#define ENABLE_EXTEND_INVEN_SYSTEM
#define ENABLE_LVL115_ARMOR_EFFECT
#define ENABLE_SLOT_WINDOW_EX
#define ENABLE_TEXT_LEVEL_REFRESH
#define ENABLE_USE_COSTUME_ATTR
#define ENABLE_DISCORD_RPC
#define ENABLE_PET_SYSTEM_EX
#define ENABLE_LOCALE_EX
#define ENABLE_NO_DSS_QUALIFICATION
//#define ENABLE_NO_SELL_PRICE_DIVIDED_BY_5
#define ENABLE_PENDANT_SYSTEM
#define ENABLE_GLOVE_SYSTEM
#define ENABLE_MOVE_CHANNEL
#define ENABLE_QUIVER_SYSTEM
#define ENABLE_RACE_HEIGHT
#define ENABLE_ELEMENTAL_TARGET
#define ENABLE_INGAME_CONSOLE
#define ENABLE_4TH_AFF_SKILL_DESC
#define ENABLE_LOCALE_COMMON
#define ENABLE_GUILD_TOKEN_AUTH
#define ENABLE_CONQUEROR_UI
#define ENABLE_DS_GRADE_MYTH

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
// ### From GameLib ###
//#define ENABLE_WOLFMAN_CHARACTER
//#ifdef ENABLE_WOLFMAN_CHARACTER
// #define DISABLE_WOLFMAN_ON_CREATE
//#endif
// #define ENABLE_MAGIC_REDUCTION_SYSTEM
#define ENABLE_MOUNT_COSTUME_SYSTEM
#define ENABLE_WEAPON_COSTUME_SYSTEM
// ### From GameLib ###
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### New System Defines - Extended Version ###

// if is define ENABLE_ACCE_COSTUME_SYSTEM the players can use shoulder sash
#define ENABLE_ACCE_COSTUME_SYSTEM
#ifdef ENABLE_ACCE_COSTUME_SYSTEM
// #define USE_ACCE_ABSORB_WITH_NO_NEGATIVE_BONUS
#endif

// if you want use SetMouseWheelScrollEvent or you want use mouse wheel to move the scrollbar
#define ENABLE_MOUSEWHEEL_EVENT

//if you want to see highlighted a new item when dropped or when exchanged
#define ENABLE_HIGHLIGHT_NEW_ITEM

// it shows emojis in the textlines
#define ENABLE_EMOJI_SYSTEM

// effects while hidden won't show up
#define __ENABLE_STEALTH_FIX__

// circle dots in minimap instead of squares
#define ENABLE_MINIMAP_WHITEMARK_CIRCLE
#define ENABLE_MINIMAP_TELEPORT_CLICK // click on minimap as gm to warp directly

// enable the won system as a currency
#define ENABLE_CHEQUE_SYSTEM
#ifdef ENABLE_CHEQUE_SYSTEM
#define DISABLE_CHEQUE_DROP
#define ENABLE_WON_EXCHANGE_WINDOW
#endif

// for debug: print received packets
// #define ENABLE_PRINT_RECV_PACKET_DEBUG

#define __BL_MULTI_LANGUAGE__
#define __BL_MULTI_LANGUAGE_PREMIUM__
#define __BL_MULTI_LANGUAGE_ULTIMATE__
#define ENABLE_GF_ATLAS_MARK_INFO // https://metin2.dev/topic/23474-gf-loadatlasmarkinfo/
#define __BL_CLIENT_LOCALE_STRING__

// ### New System Defines - Extended Version ###
//////////////////////////////////////////////////////////////////////////
#define ENABLE_TARGET_INFORMATION_SYSTEM		// Mob info
#define ENABLE_FULL_YANG

#define ENABLE_IKASHOP_RENEWAL
#define ENABLE_IKASHOP_ENTITIES
#define EXTEND_IKASHOP_PRO
#define EXTEND_IKASHOP_ULTIMATE
#define ENABLE_LARGE_DYNAMIC_PACKETS

//////////////////////////////////////////////////////////////////////////

// ### Daginik Dosyalardan Toplanan Ayarlar ###
// <Client/EterBase/error.cpp>
#define ENABLE_CRASH_MINIDUMP
// <Client/EterBase/ServiceDefs.h>
//#define _IMPROVED_PACKET_ENCRYPTION_
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
#define ENABLE_NO_MOUNT_CHECK
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
// ### Pack/Python Ayarlari ###
// Bu blok constinfo.py'ye tools/define_sync.py ile senkronlanir.
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
// #define SHOW_ONLY_ACTIVE_SKILL          // sadece aktif beceriler
#define HIDE_SUPPORT_SKILL_POINT          // destek beceri puani gizle
// #define SYSTEM_MENU_FOR_PORTAL          // sistem menusu portal

// ### Hic Tanimlanmamis Kapali Ozellikler (envanter) ###
// #define ENABLE_678TH_SKILL                         // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_AURA_COSTUME_SYSTEM                 // Client/GameLib/ItemManager.cpp
// #define ENABLE_AUTO_L2R                            // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_AUTO_SYSTEM                         // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_CHANGELOOK_SYSTEM                   // Client/UserInterface/PythonIkarusShop.h, Server/db/src/ClientManagerIkarusShop.cpp, Server/db/src/IkarusShopCache.cpp
// #define ENABLE_CONQUEROR_LEVEL                     // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_DISCORD_JOIN_URL                    // Client/UserInterface/PythonNetworkStreamPhaseGame.cpp
// #define ENABLE_ENVIRONMENT_EFFECT_OPTION           // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_GOLD_FIELD_AS_SELL_PRICE            // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_GROWTH_PET_SYSTEM                   // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_HELP_RENEWAL                        // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_ITEM_COUNT_LIMIT_SYSTEM             // Client/UserInterface/Packet.h, Server/game/src/packet.h
// #define ENABLE_MONSTER_CARD                        // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_PLAYER_CHECKAFFECT                  // Client/UserInterface/PythonPlayerModule.cpp
// #define ENABLE_PREMIUM_LOOT_FILTER                 // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_SEALBIND_SYSTEM                     // Client/UserInterface/PythonItemModule.cpp, Client/UserInterface/PythonPlayerModule.cpp
// #define ENABLE_SOULBIND_SYSTEM                     // Client/GameLib/ItemData.h, Client/UserInterface/PythonApplicationModule.cpp, Server/game/src/ikarus_shop_manager.cpp
// #define ENABLE_UI_CIRCLE                           // Client/UserInterface/PythonApplicationModule.cpp
// #define ENABLE_UI_MOVING                           // Client/UserInterface/PythonApplicationModule.cpp
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
