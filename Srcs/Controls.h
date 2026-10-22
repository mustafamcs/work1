#ifndef __INC_METIN2_CONTROLS_H__
#define __INC_METIN2_CONTROLS_H__
#pragma once

// =========================================================================
// Controls.h — ORTAK AYAR DOSYASI (client + server)
// Tum sistem ayarlari/defineleri yalnizca bu dosyadan yonetilir.
// Aktif : #define X  veya  #define X <deger>
// Kapali: // #define X
// =========================================================================

//////////////////////////////////////////////////////////////////////////
// ### ZORUNLU — kapatilamaz ###
// Bu flag'ler kapali iken sistem calismaz veya ek veri dosyasi gerekir.
// Tumunu kapali derleme testiyle dogrulandi (tools/script/89_define_test.bat).

#define ENABLE_TRANSLATE_LUA	// questlib.lua/locale.lua gameforge'u kosulsuz okur; kapaliysa kanal core'lari LoadQuestLocale'de duser
#define ENABLE_PROTO_FROM_DB	// kapaliysa server/db/ altinda uretilmis mob_proto.txt + item_proto.txt + *_names.txt gerekir (DumpProto -u -i -m)
#define ENABLE_NUMERIC_FIELD	// txt proto'daki numeric kolonlar strict name-parse'da patlar
#define ENABLE_AUTODETECT_VNUMRANGE	// player.item_proto'da vnum_range kolonu yok; kapaliysa db SELECT patlar
#define LOCALE_SERVICE_EUROPE	// servis kimligi (IsEUROPE/security key); kapaliysa isim YMIR'e duser
#define ENABLE_LOCALE_COMMON	// py: locale_interface_ex.txt + locale/common/ui yollari buna bagli
#define __BL_CLIENT_LOCALE_STRING__	// C++: locale_string.txt + locale_quest.txt + locale_quiz.txt yukleme
#define __BL_MULTI_LANGUAGE__	// py: locale dosyalarini UTF-8 tutan dali secer; kapaliysa CP1254'e cevirip karakterler bozulur
#define __BL_MULTI_LANGUAGE_PREMIUM__	// py pack'in premium dallarina bagli (18+ kullanim)
#define __BL_MULTI_LANGUAGE_ULTIMATE__	// py pack'in ultimate dallarina bagli (22+ kullanim)
#define KEEP_ACCOUNT_CONNETION_ENABLE 1	// py: auth'a LOGIN3 gonderip login key alir; kapaliysa CG_LOGIN->GD_LOGIN db'de islencek case yok, login asili kalir
#define ENABLE_GF_ATLAS_MARK_INFO	// *_point.txt dosyalari GF formatinda (x y vnum); kapaliysa klasik format beklenir
#define ARMOR_SPECULAR_ENABLE 1	// item_proto value3 = armor shape index; kapaliysa SetShape(vnum) yapip temel beden cizer, zirh gorunmez
#define CAMERA_MAX_DISTANCE_SHORT 2500.0f	// py: constinfo bunu app.SetCameraMaxDistance'a verir; 0 olursa zoom kilitli kalir
#define ENABLE_GM_FLAG_IF_TEST_SERVER	// TEST_SERVER:1 login icin zorunlu; o modda server AFF_YMIR'i bastirir, bu flag GM logosunu geri acar
#define CAMERA_MAX_DISTANCE_LONG 3500.0f	// py: uioption kamera modu listesi (SHORT/LONG)

//////////////////////////////////////////////////////////////////////////
// ### Dil ve Bolge ###
// #define ENABLE_LOCALE_EX
// #define LOCALE_SERVICE_GLOBAL
// #define LOCALE_SERVICE_JAPAN
// #define LOCALE_SERVICE_WE_JAPAN
// #define LOCALE_SERVICE_YMIR
// #define LOCALE_SERVICE_VIETNAM_MILD
// #define LOCALE_SERVICE_STAGE_DEVELOPMENT
// #define LOCALE_SERVICE_STAGE_TEST
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Ag ve Paket ###
// #define __UDP_BLOCK__
// #define ENABLE_PORT_SECURITY
// #define ENABLE_LARGE_DYNAMIC_PACKETS
//#define _IMPROVED_PACKET_ENCRYPTION_
#ifdef _IMPROVED_PACKET_ENCRYPTION_
// #define USE_IMPROVED_PACKET_DECRYPTED_BUFFER
#endif
// #define ENABLE_SEQUENCE_SYSTEM
// #define ENABLE_AUTODETECT_INTERNAL_IP
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Veritabani / Proto ###
// #define ENABLE_PROTOSTRUCT_AUTODETECT
// #define ENABLE_EXPTABLE_FROMDB
// #define ENABLE_ITEMAWARD_REFRESH
// #define ENABLE_DEFAULT_PRIV
// #define ENABLE_DB_SQL_LOG
// #define ENABLE_SPAMDB_REFRESH
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Karakter ve Oyuncu ###
// Karakter yuvasi 4. pid5 acilmaz.
// #define ENABLE_PLAYER_PER_ACCOUNT5
// #define ENABLE_LEVEL_IN_TRADE
// #define ENABLE_RACE_HEIGHT
// #define ENABLE_GM_FLAG_IF_TEST_SERVER
// #define ENABLE_GM_FLAG_FOR_LOW_WIZARD
// #define ENABLE_CANSEEHIDDENTHING_FOR_GM
// #define ENABLE_STATPLUS_NOLIMIT
// #define ENABLE_SET_STATE_WITH_TARGET
// #define ENABLE_ANTI_CMD_FLOOD
// #define ENABLE_CHECK_GHOSTMODE
		// #define ENABLE_TP_SPEED_CHECK
// #define ENABLE_ACCOUNT_W_SPECIALCHARS
// #define ENABLE_LOCALECHECK_CHANGENAME
// #define ENABLE_PLAYER_CHECKAFFECT
// #define USE_OPENID
// #define DISABLE_STOP_RIDING_WHEN_DIE //	olunce at/binek dusmez
//#define ENABLE_LIMIT_TIME
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Savas ve Yetenek ###
// #define ENABLE_DICE_SYSTEM
// #define ENABLE_EFFECT_PENETRATE
// #define ENABLE_NEWEXP_CALCULATION
// #define ENABLE_EFFECT_EXTRAPOT
// #define ENABLE_FORCE2MASTERSKILL
// #define ENABLE_SKILL_COOLDOWN_CHECK
// #define ENABLE_SKILL_FLAG_PARTY
// #define ENABLE_ELEMENTAL_TARGET
// #define ENABLE_NULLIFYAFFECT_LIMIT
// #define ENABLE_MASTER_SKILLBOOK_NO_STEPS
// #define ENABLE_IMMUNE_PERC
// #define ENABLE_NO_DAMAGE_QUEST_RUNNING
// #define ENABLE_KILL_EVENT_FIX // kill lua event 0 exp fix (onerilen)
// #define ENABLE_MAGIC_REDUCTION_SYSTEM
#ifdef ENABLE_MAGIC_REDUCTION_SYSTEM
// #define USE_MAGIC_REDUCTION_STONES
#endif
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Esya ve Envanter ###
// #define ENABLE_NEW_EQUIPMENT_SYSTEM
// #define ENABLE_EXTEND_INVEN_SYSTEM
// #define ENABLE_BELT_INVENTORY_EX
// #define ENABLE_SLOT_WINDOW_EX
// #define ENABLE_PENDANT_SYSTEM
// Eldiven uc profilde de yok.
// #define ENABLE_GLOVE_SYSTEM
// #define ENABLE_QUIVER_SYSTEM
// #define ENABLE_ITEM_ATTR_COSTUME
// #define ENABLE_ITEM_PROTO_MAP
// #define ENABLE_ITEM_RARE_ATTR_LEVEL_PCT
// #define ENABLE_UNIQUE_ITEM_AUTOSPLIT
// #define ENABLE_ADDSTONE_FAILURE
// #define ENABLE_BOOKS_STACKFIX
// #define ENABLE_IMMUNE_FIX
// #define ENABLE_FIREWORK_STUN
// #define ENABLE_HIGHLIGHT_NEW_ITEM // yeni dusen/takas esyasi vurgu
// #define ENABLE_EXTEND_ITEM_AWARD
#ifdef ENABLE_EXTEND_ITEM_AWARD
	// #define USE_ITEM_AWARD_CHECK_ATTRIBUTES // item_attr lvl1-5 min-max limiti asimini engeller
#endif
// #define ENABLE_NO_PICKUP_LIMIT
// #define ENABLE_ITEM_COUNT_LIMIT_SYSTEM
// #define ENABLE_MONSTER_CARD
// #define ENABLE_SEALBIND_SYSTEM
// #define ENABLE_SOULBIND_SYSTEM
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Kostum ve Gorunum ###
// #define ENABLE_COSTUME_SYSTEM
// #define ENABLE_MOUNT_COSTUME_SYSTEM
// #define ENABLE_MOUNT_COSTUME_EX_SYSTEM
// #define ENABLE_WEAPON_COSTUME_SYSTEM
// #define ENABLE_USE_COSTUME_ATTR
// #define ENABLE_ACCE_COSTUME_SYSTEM // omuz sasi (sabit surum)
#ifdef ENABLE_ACCE_COSTUME_SYSTEM
// #define USE_ACCE_ABSORB_WITH_NO_NEGATIVE_BONUS // sadece pozitif bonus absorbe
#endif
// #define ENABLE_ACCE_SYSTEM                  // eski acce sistemi
// #define ENABLE_SASH_SYSTEM
// #define ENABLE_AURA_COSTUME_SYSTEM
// #define ENABLE_CHANGELOOK_SYSTEM
// #define ENABLE_LVL115_ARMOR_EFFECT
// #define ENABLE_HAIR_SPECULAR
// #define USE_WEAPON_COSTUME_WITH_EFFECT
// #define USE_BODY_COSTUME_WITH_EFFECT
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Ejderha Ruhu ###
// #define ENABLE_DRAGON_SOUL_SYSTEM
// #define ENABLE_DS_GRADE_MYTH
// #define ENABLE_NO_DSS_QUALIFICATION
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Pet ve Binek ###
// #define ENABLE_ENERGY_SYSTEM
// #define ENABLE_PET_SYSTEM_EX
// #define __PET_SYSTEM__
#ifdef __PET_SYSTEM__
// #define USE_ACTIVE_PET_SEAL_EFFECT
// #define PET_SEAL_ACTIVE_SOCKET_IDX 2
// #define USE_PET_SEAL_ON_LOGIN
#endif
// #define ENABLE_GROWTH_PET_SYSTEM
// #define ENABLE_NO_MOUNT_CHECK
// #define ENABLE_MOUNT_ENTITY_REFRESH
// #define ENABLE_INFINITE_HORSE_HEALTH_STAMINA
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Ekonomi ve Dukkan ###
// #define FULL_YANG        // long long yang destegi (server)
// #define ENABLE_FULL_YANG // client tarafi
// #define ENABLE_CHECK_SELL_PRICE
// #define ENABLE_NO_SELL_PRICE_DIVIDED_BY_5
// #define ENABLE_GOLD_FIELD_AS_SELL_PRICE
// #define ENABLE_OPEN_SHOP_WITH_ARMOR
// #define ENABLE_NEWSTUFF

// --- Ikarus Shop (offline dukkan) ---
// #define ENABLE_IKASHOP_RENEWAL
// #define EXTEND_IKASHOP_PRO
// #define EXTEND_IKASHOP_ULTIMATE
// #define ENABLE_IKASHOP_ENTITIES
// #define ENABLE_IKASHOP_GM_PROTECTION
// #define ENABLE_IKASHOP_LOGS
// #define ENABLE_OFFLINESHOP_DEBUG
// #define ENABLE_PC_OPENSHOP
//#define ENABLE_SHOP_BLACKLIST

// Won / cheque yok. Yang bigint. Ikinci para kolonu acilmaz.
// #define ENABLE_CHEQUE_SYSTEM
#ifdef ENABLE_CHEQUE_SYSTEM
// #define ENABLE_SHOP_USE_CHEQUE
// #define DISABLE_CHEQUE_DROP
// #define ENABLE_WON_EXCHANGE_WINDOW
#endif
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Lonca ve Sosyal ###
// #define ENABLE_GUILD_TOKEN_AUTH
// #define ENABLE_GUILD_COMMENT_ANTIFLOOD
// #define ENABLE_D_NJGUILD
// #define ENABLE_NEWGUILDMAKE
// #define ENABLE_PARTYKILL
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Sohbet ###
// #define ENABLE_CHAT_COLOR_SYSTEM
// #define ENABLE_CHAT_LOGGING
// #define ENABLE_CHAT_SPAMLIMIT
// #define ENABLE_WHISPER_CHAT_SPAMLIMIT
// #define ENABLE_FULL_NOTICE
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Gorev ve Event ###
//#define ENABLE_QUEST_CATEGORY
// #define ENABLE_QUEST_DIE_EVENT
// #define ENABLE_QUEST_BOOT_EVENT
// #define ENABLE_QUEST_DND_EVENT
// #define ENABLE_NEW_EVENT_STRUCT
#ifdef ENABLE_NEW_EVENT_STRUCT
// #define USE_NEW_EVENT_TEXT_AUTO_Y
#endif
// #define ENABLE_MONARCH_MOB_CMD_MAP_CHECK
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Harita, Dunya ve Toplayicilik ###
enum eCommonDefines {
	MAP_ALLOW_LIMIT = 32, // 32 default
};
// #define ENABLE_MOVE_CHANNEL
// #define ENABLE_REDUCED_ENTITY_VIEW
// #define ENABLE_GOHOME_IF_MAP_NOT_ALLOWED
// #define ENABLE_GOHOME_IF_MAP_NOT_EXIST
// #define ENABLE_GOTO_LAG_FIX
// #define ENABLE_CMD_WARP_IN_DUNGEON
// #define ENABLE_FISHINGROD_RENEWAL
// #define ENABLE_PICKAXE_RENEWAL
// #define ENABLE_TARGET_INFORMATION_SYSTEM // Mob drop info
// #define WJ_SHOW_MOB_INFO
#ifdef WJ_SHOW_MOB_INFO
// #define ENABLE_SHOW_MOBAIFLAG
// #define ENABLE_SHOW_MOBLEVEL
// #define WJ_SHOW_MOB_INFO_EX
#endif
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Istemci Arayuz ve Gorsel ###
// #define ENABLE_DISCORD_RPC
// #define ENABLE_DISCORD_JOIN_URL
// #define ENABLE_EMOJI_SYSTEM
// #define ENABLE_MOUSEWHEEL_EVENT
// #define ENABLE_MINIMAP_WHITEMARK_CIRCLE
// #define ENABLE_MINIMAP_TELEPORT_CLICK // gm minimap tikla-isinlan
// #define ENABLE_INGAME_CONSOLE
// #define ENABLE_CONQUEROR_UI
// #define ENABLE_CONQUEROR_LEVEL
// #define ENABLE_UI_CIRCLE
// #define ENABLE_UI_MOVING
// #define ENABLE_ENVIRONMENT_EFFECT_OPTION
// #define ENABLE_PREMIUM_LOOT_FILTER
// #define __BL_OFFICIAL_LOOT_FILTER__
// #define __BL_CLIP_MASK__
// #define __BL_MOUSE_WHEEL_TOP_WINDOW__
// #define ENABLE_4TH_AFF_SKILL_DESC
// #define ENABLE_TEXT_LEVEL_REFRESH
// #define ENABLE_ATLASINFO_FROM_ROOT
// #define __ENABLE_STEALTH_FIX__ // gizliyken efektler gorunmez
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Paket/Dosya Okuma (client) ###
// #define ENABLE_PACK_GET_CHECK
// #define ENABLE_CRC32_CHECK
// #define ENABLE_LOAD_ITEM_LIST_FROM_ROOT
// #define ENABLE_LOAD_ITEM_SCALE_FROM_ROOT
// #define ENABLE_LOAD_SKILL_TABLE_FROM_ROOT
// #define ENABLE_LOAD_ALTER_ITEMICON
// #define ENABLE_SKIN_EXTENDED
// #define ENABLE_WALK_RUN_ANI_ALTERNATIVE
// #define ENABLE_NPC_WITHOUT_COLLISIONS
#ifndef ENABLE_NPC_WITHOUT_COLLISIONS
// #define ENABLE_PETS_WITHOUT_COLLISIONS
// #define ENABLE_SHOPS_WITHOUT_COLLISIONS
// #define ENABLE_MOUNTS_WITHOUT_COLLISIONS
#endif
// #define ENABLE_NEW_MOB_PROTO_STRUCT_20141125	// bleeding resistance 2014/11/25
// #define ENABLE_NEW_MOB_PROTO_STRUCT_20151020	// claw resistance 2015/10/20
// #define ENABLE_FOG_LOAD
//#define USE_LEVEL
//#define USE_CRAMERS_RULE
// #define USE_SPEEDGRASS   // Constants.h hicbir yerde include edilmiyor - orijinalde kapaliydi
// #define ENABLE_SIMPLE_REFINED_EFFECT_CHECK
// #define USE_RELATIVE_PATH
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Guvenlik ve Anti-Hile ###
// #define ENABLE_PYLIB_CHECK
// #define ENABLE_MILES_CHECK
// #define ENABLE_DAEMONPROTECTION
// #define ENABLE_HACK_TELEPORT_LOG
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### GM ve Debug ###
// #define ENABLE_CMD_PLAYER
// #define ENABLE_CMD_IPURGE_EX
// #define ENABLE_GENERAL_CMD
// #define ENABLE_GENERAL_CONFIG
// #define ENABLE_BLOCK_CMD_SHORTCUT
// #define ENABLE_SHOWNPCLEVEL
// #define ENABLE_CRASH_MINIDUMP
// #define DEBUG_ALLOC                  // debug allocator/DebugPtr sistemi (acinca USE_DEBUG_PTR otomatik gelir)
// #define ENABLE_SYSLOG_PACKET_SENT // debug purposes
// #define ENABLE_PRINT_RECV_PACKET_DEBUG // gelen paketleri yazdir
// #define ENABLE_GOOGLE_TEST
// #define USE_STACKTRACE
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Pack/Python Ayarlari ###
// Buradaki tum tanimlar derleme sirasinda app.X olarak python'a aktarilir.
// Aktif: #define X / #define X <deger>   Kapali: // #define X

// #define ENABLE_NEW_LEVELSKILL_SYSTEM    // 5 (B,M,G,P,F) beceri .mse yukler
// #define ENABLE_RANDOM_CHANNEL_SEL       // istemci acilisinda rastgele kanal
// #define ENABLE_CLEAN_DATA_IF_FAIL_LOGIN // basarisiz giriste id/sifre silme
// #define ENABLE_PASTE_FEATURE              // ctrl+v aktif
// #define ENABLE_FULLSTONE_DETAILS          // tasin tum bonuslarini goster
// #define ENABLE_REFINE_PCT               // refine diyalogunda basari yuzdesi
// #define EXTRA_UI_FEATURE                  // ekstra ui ozellikleri
// #define NEW_678TH_SKILL_ENABLE            // 6. savasci/ninja becerileri
// #define ENABLE_678TH_SKILL
// #define SELECT_CHAR_NO_DELAY 0.5          // karakter secim bekleme suresi
// #define ENABLE_ACTIVE_PET_SEAL_EFFECT     // pet muhru aktif efekti
// #define ENABLE_RECURSIVE_UI_DESTROY     // ui bilesenlerini zorla temizle
// #define ENABLE_CMDCHAT_VARIADIC_ARGS      // cmdchat degisken arguman
// #define ENABLE_SELF_STACK_SCROLLS         // scroll kendinden stack
// #define ENABLE_SAVE_ACCOUNT               // hesap kaydetme
// #define ENABLE_ENGNUM_DELETE_CODE         // karakter silme kodu sayisal
// #define ENABLE_CHAT_COMMAND               // sohbet komutlari
// #define ENABLE_LAST_SENTENCE_STACK        // son sohbet satiri stack
// #define ENABLE_INSULT_CHECK               // kufur kontrolu
// #define DISABLE_GUILD_SKILL             // lonca becerisi kapali
// #define DISABLE_DECLARE_WAR             // savas ilani kapali
// #define ENABLE_HELP_MULTIPAGE           // yardim cok sayfali
// #define ENABLE_HELP_RENEWAL
// #define ENABLE_DEFAULT_UI_BOARD 1         // ikarus shop varsayilan board
// #define ITEM_MALL_BUTTON_ENABLE           // envanter item mall butonu
// #define LEAVE_BUTTON_FOR_POTAL          // portaldan ayrilma butonu
// #define NOT_NEED_DELETE_CODE            // silme kodu gerekmesin
// #define SCREENSHOT_CWDSAVE                // ekran goruntusu cwd kaydet
// #define SKIP_LOGIN_PHASE                // login asamasini atla
// #define SKIP_LOGIN_PHASE_SUPPORT_CHANNEL
// #define FULL_BACK_IMAGE                 // login tam ekran arkaplan
// #define VIRTUAL_KEYBOARD_RAND_KEY         // sanal klavye karisik tus
// #define LOGIN_DELAY_SEC 0.0f              // login gecikme suresi
// #define VIRTUAL_KEYBOARD_NUM_KEYS 46      // sanal klavye tus sayisi
// #define SHOW_ONLY_ACTIVE_SKILL          // sadece aktif beceriler
// #define HIDE_SUPPORT_SKILL_POINT          // destek beceri puani gizle
// #define SYSTEM_MENU_FOR_PORTAL          // sistem menusu portal
// #define ENABLE_DRAGON_GATE              // pack ui scriptleri (app.X sorgusu)
// #define ENABLE_MERCENARY_SYSTEM
// #define ENABLE_SUNGMAHEE_GATE
// #define ENABLE_ADDITIONAL_EQUIPMENT_PAGE
// #define ENABLE_SERVER_SELECT_RENEWAL
// #define ENABLE_PREMIUM_PRIVATE_SHOP
// #define ENABLE_AUTO_L2R
// #define ENABLE_AUTO_SYSTEM

// --- Degerli ayarlar (python'a aynen aktarilir; kapatmak icin silme, degeri degistir) ---
// #define IN_GAME_SHOP_ENABLE 1
// #define CONSOLE_ENABLE 0
// #define PVPMODE_ENABLE 1
// #define PVPMODE_TEST_ENABLE 0
// #define PVPMODE_ACCELKEY_ENABLE 1
// #define PVPMODE_ACCELKEY_DELAY 0.5f
// #define PVPMODE_PROTECTED_LEVEL 15
// #define FOG_LEVEL0 4800.0f
// #define FOG_LEVEL1 9600.0f
// #define FOG_LEVEL2 12800.0f
// #define CAMERA_MAX_DISTANCE_SHORT 2500.0f	// ZORUNLU bloguna tasindi
// #define CAMERA_MAX_DISTANCE_LONG 3500.0f	// ZORUNLU bloguna tasindi
// #define CHRNAME_COLOR_INDEX 0
// #define ENVIRONMENT_NIGHT "d:/ymir work/environment/moonlight04.msenv"
// #define HIGH_PRICE 500000
// #define MIDDLE_PRICE 50000
// #define ERROR_METIN_STONE 28960
// #define SUB2_LOADING_ENABLE 1
// #define EXPANDED_COMBO_ENABLE 1
// #define CONVERT_EMPIRE_LANGUAGE_ENABLE 0
// #define USE_ITEM_WEAPON_TABLE_ATTACK_BONUS 0
// #define ADD_DEF_BONUS_ENABLE 0
// #define LOGIN_COUNT_LIMIT_ENABLE 0
// #define USE_SKILL_EFFECT_UPGRADE_ENABLE 1
// #define VIEW_OTHER_EMPIRE_PLAYER_TARGET_BOARD 1
// #define GUILD_MONEY_PER_GSP 100
// #define GUILD_WAR_TYPE_SELECT_ENABLE 1
// #define TWO_HANDED_WEAPON_ATT_SPEED_DECREASE_VALUE 10
// #define DEFAULT_HAIR_COLOR_ENABLE 1       // HAIR_COLOR_ENABLE C++ global ile cakisiyor - py'ya HAIR_COLOR_ENABLE olarak aktarilir
// #define ARMOR_SPECULAR_ENABLE 1	// ZORUNLU bloguna tasindi
// #define WEAPON_SPECULAR_ENABLE 1
// #define SEQUENCE_PACKET_ENABLE 1
// #define MINIMAP_POSITIONINFO_ENABLE 1

#endif // __INC_METIN2_CONTROLS_H__
