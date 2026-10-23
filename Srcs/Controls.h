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
// ### Guvenlik — AKTIF ###
// Oyun yapisini degistirmez: yeni yuva/esya/sistem yok, savas ve ekonomi kurali degismez.
// PORT_SECURITY: ADMINPAGE_IP1 tum CONFIG'lerde 127.0.0.1 tanimli (dogrulandi).
// Sifreleme+sequence+lonca token: client+server ayni Controls.h'ten derlendigi icin eslesir.
//
// --- Ag ---
#define __UDP_BLOCK__					// olu UDP dinleyicisini kapatir (mother_port UDP)
#define ENABLE_PORT_SECURITY			// DB/P2P/admin komut portlari localhost+LAN'a kilitli
#define _IMPROVED_PACKET_ENCRYPTION_	// DH anahtar anlasmasi: sabit TEA yerine oturum bazli sifreleme
#define USE_IMPROVED_PACKET_DECRYPTED_BUFFER	// her DESC'e ayri decrypted buffer (sifreleme ile birlikte)
#define ENABLE_SEQUENCE_SYSTEM			// paket sira no: enjeksiyon/replay engeli (server tarafi)
#define SEQUENCE_PACKET_ENABLE 1		// py: client'in sequence gondermesini acar (intrologin.Connect)
#define ENABLE_LARGE_DYNAMIC_PACKETS	// paket tamponu 64K->600K; ikarus kapali, tel ustundeki normal paket basligi ayni kalir
#define ENABLE_AUTODETECT_INTERNAL_IP	// PUBLIC_IP bulunamazsa INTERNAL_IP'yi kullanir; IP zaten yaziliysa degismez
//
// --- Anti-hile / flood ---
#define ENABLE_TP_SPEED_CHECK			// tek pakette >25m yaya / >60m binek hareketini engeller
#define ENABLE_HACK_TELEPORT_LOG		// TP_SPEED_CHECK suphelisini LogManager::HackLog'a yazar
#define ENABLE_CHECK_GHOSTMODE			// oluyken hareket paketini reddeder
#define ENABLE_SKILL_COOLDOWN_CHECK		// beklemedeki beceri paketini ve asiri vurus sayisini reddeder
#define ENABLE_ANTI_CMD_FLOOD			// GM haric komut spam'i 100ms'de 1 ile sinirli (PulseManager)
#define ENABLE_BLOCK_CMD_SHORTCUT		// komut on eki eslesmez; tam komut adi gerekir (kisa yazimla baska komuta dusmeyi keser)
#define ENABLE_CHAT_SPAMLIMIT			// sohbet flood: sayac>=4 sonrasi keser, 10'da kick
#define ENABLE_WHISPER_CHAT_SPAMLIMIT	// fisilti flood: sayac>=10 -> disconnect
#define ENABLE_GUILD_COMMENT_ANTIFLOOD	// lonca yorum spam siniri (PulseManager)
#define ENABLE_GUILD_TOKEN_AUTH			// lonca paketlerine token: sahte lonca islemini reddeder (yeni pencere/kural yok)
#define ENABLE_MONARCH_MOB_CMD_MAP_CHECK	// imparator mob cagirma yalniz kendi krallik haritasinda
#define ENABLE_SPAMDB_REFRESH			// spam_db kelime listesini periyodik yeniden yukler (varsayilan 10 dk)
//
// --- Dupe / gecersiz konum ---
#define ENABLE_CHECK_SELL_PRICE			// DB yukunde satis<alis/5 itemleri duzeltir (yang-dupe onlemi)
#define ENABLE_GOHOME_IF_MAP_NOT_ALLOWED	// izinli olmayan haritaya isinlanmayi koparmak yerine koyune yollar
#define ENABLE_GOHOME_IF_MAP_NOT_EXIST	// kayitli konum gecersizse koparmak yerine baslangic koyune alir
//
// --- Kayit (oyun kurali degismez) ---
#define ENABLE_CHAT_LOGGING				// yalniz GM sohbet/fisilti/lonca/grup satirini chat_log tablosuna yazar
#define ENABLE_DB_SQL_LOG				// CONFIG'te SQL_LOG varsa log veritabanina baglanir; yoksa atlar
#define ENABLE_CRASH_MINIDUMP			// istemci cokusunde logs\ altina .dmp yazar; oyun akisi ayni
//
// --- Istemci butunluk ---
#define ENABLE_PACK_GET_CHECK			// pack.Get yalniz .py/.pyc/.txt verir
#define ENABLE_CRC32_CHECK				// guvenlik tipi paket girisinde CRC32 tutmazsa dosyayi okumaz
#define ENABLE_PYLIB_CHECK				// lib\ icindeki bilinen .pyc boyut/CRC uyusmazsa istemci acilmaz (listede olmayan dosya serbest)
#define ENABLE_MILES_CHECK				// miles .m3d/.asi/.flt/.mix boyut/CRC ve yabanci dosya kontrolu; uyusmazsa istemci acilmaz
//
// --- Duzeltme (yeni sistem degil; bozuk olan mevcut davranisi toplar) ---
#define ENABLE_KILL_EVENT_FIX			// exp dagitimi bos donunce kill gorevi de dusuyordu; en cok vuranla gorev devam eder
#define ENABLE_BOOKS_STACKFIX			// beceri kitabi tum desteyi silmez; yalniz 1 adet duser
#define ENABLE_IMMUNE_FIX				// kusaninca proto immune (hep 0) bayragi karakterin immunesini sifirliyordu
#define ENABLE_GOTO_LAG_FIX				// isinlaninca ViewCleanup yalniz oyuncuda; moblarda gereksiz temizlik lag'i
#define __ENABLE_STEALTH_FIX__			// gizliyken efektler gorunmez
#define ENABLE_TEXT_LEVEL_REFRESH		// /advance sonrasi isim ustu seviye yazisi yenilenir
#define ENABLE_DAEMONPROTECTION					// dpdll.dll watchdog (CRC/size UserInterface.cpp'de, build: 99_dpdll_build.bat)
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Yapiyai Degistirmeyen — AKTIF ###
// Yeni yuva/esya/sistem yok; veri kaynagi, bakim, log ve client arayuz/veri
// okuma tercihleri. app.X olarak python'a da aktarilir.
//
// --- Veri kaynagi / bakim ---
#define ENABLE_PROTOSTRUCT_AUTODETECT			// proto revizyonunu boyuttan algilar
#define ENABLE_EXPTABLE_FROMDB				// exp egrisi DB'deki exp_table'dan okunur
#define ENABLE_ITEMAWARD_REFRESH				// item_award 5 sn'de bir tazelenir
#define ENABLE_DEFAULT_PRIV					// suresi dolan priv_settings satirlarini temizler
//
// --- Log / debug / GM araclari ---
#define ENABLE_SHOWNPCLEVEL					// npc uzerinde seviye gosterir
#define ENABLE_CMD_PLAYER					// /player GM komutu
#define ENABLE_CMD_IPURGE_EX				// /ipurge GM komutu
// #define ENABLE_SYSLOG_PACKET_SENT			// syslog'u dakikada MB'larca SENT HEADER spam'iyle dolduruyor; sadece paket debug'i icin gecici acilir
#define ENABLE_PRINT_RECV_PACKET_DEBUG			// gelen paketleri yazdirir
#define USE_STACKTRACE					// kritik hatada stack trace (Windows: CaptureStackBackTrace+SymFromAddr)
#define DEBUG_ALLOC						// debug allocator + DebugPtr
//
// --- Bilgi goruntuleme ---
#define ENABLE_TARGET_INFORMATION_SYSTEM			// mob drop/level bilgi penceresi
#define WJ_SHOW_MOB_INFO					// mob uzerinde bilgi gosterimi
#define ENABLE_SHOW_MOBAIFLAG					// mob ailag gosterimi
#define ENABLE_SHOW_MOBLEVEL					// mob seviye gosterimi
#define WJ_SHOW_MOB_INFO_EX					// genisletilmis mob bilgisi
#define VIEW_OTHER_EMPIRE_PLAYER_TARGET_BOARD 1		// diger krallik oyuncularinda hedef tahtasi
//
// --- Client arayuz ---
#define ENABLE_HIGHLIGHT_NEW_ITEM				// yeni dusen/takas esyasi vurgu
#define ENABLE_MOUSEWHEEL_EVENT				// mouse wheel event destegi
#define ENABLE_MINIMAP_WHITEMARK_CIRCLE			// minimap beyaz isaret dairesi
#define ENABLE_MINIMAP_TELEPORT_CLICK				// gm minimap tikla-isinlan
#define ENABLE_INGAME_CONSOLE					// oyun ici konsol
#define ENABLE_DISCORD_RPC					// discord rich presence
#define ENABLE_DISCORD_JOIN_URL					// discord join url
#define ENABLE_EMOJI_SYSTEM					// sohbette emoji
#define ENABLE_CHAT_COLOR_SYSTEM				// sohbet renk sistemi
#define ENABLE_ENVIRONMENT_EFFECT_OPTION			// cevre efekti secenekleri
#define SHOW_ONLY_ACTIVE_SKILL					// sadece aktif beceriler
#define HIDE_SUPPORT_SKILL_POINT				// destek beceri puani gizle
#define ENABLE_4TH_AFF_SKILL_DESC				// 4. etki beceri aciklamasi
#define ENABLE_FULLSTONE_DETAILS				// tasin tum bonuslarini goster
#define ENABLE_REFINE_PCT					// refine diyalogunda basari yuzdesi
#define ENABLE_PASTE_FEATURE					// ctrl+v aktif
#define ENABLE_ENGNUM_DELETE_CODE				// karakter silme kodu sayisal
#define NOT_NEED_DELETE_CODE					// silme kodu gerekmesin
#define ENABLE_CLEAN_DATA_IF_FAIL_LOGIN			// basarisiz giriste id/sifre silme
#define ENABLE_CHAT_COMMAND					// sohbet komutlari
#define ENABLE_LAST_SENTENCE_STACK				// son sohbet satiri stack
#define ENABLE_INSULT_CHECK					// kufur kontrolu
#define ENABLE_SELF_STACK_SCROLLS				// scroll kendinden stack
#define ENABLE_RECURSIVE_UI_DESTROY				// ui bilesenlerini zorla temizle
#define ENABLE_CMDCHAT_VARIADIC_ARGS				// cmdchat degisken arguman
#define ITEM_MALL_BUTTON_ENABLE					// envanter item mall butonu
#define LEAVE_BUTTON_FOR_POTAL					// portaldan ayrilma butonu
#define SYSTEM_MENU_FOR_PORTAL					// sistem menusu portal
#define ENABLE_DEFAULT_UI_BOARD 1				// varsayilan board
#define ENABLE_RANDOM_CHANNEL_SEL				// istemci acilisinda rastgele kanal
#define ENABLE_SERVER_SELECT_RENEWAL			// renewal sunucu secim modu (loginwindow.py ServerList/ChannelList'i her durumda olusturur)
//
// --- Render / dosya okuma ---
#define WEAPON_SPECULAR_ENABLE 1				// silah specular
#define DEFAULT_HAIR_COLOR_ENABLE 1				// HAIR_COLOR_ENABLE C++ global ile cakisiyor - py'ya HAIR_COLOR_ENABLE olarak aktarilir
#define ENABLE_HAIR_SPECULAR					// sac specular
#define ENVIRONMENT_NIGHT "d:/ymir work/environment/moonlight04.msenv"	// gece ortami
#define FOG_LEVEL0 4800.0f					// sis seviye 0
#define FOG_LEVEL1 9600.0f					// sis seviye 1
#define FOG_LEVEL2 12800.0f					// sis seviye 2
#define ENABLE_FOG_LOAD						// fog dosyasi yukleme
#define USE_SPEEDGRASS						// speedtree grass render (SpeedGrassRT include duzeltildi)
#define __BL_CLIP_MASK__					// clip mask render (CGraphicImageInstance::Render(const RECT*) eklendi)
#define ENABLE_SKIN_EXTENDED					// genisletilmis skin
#define ENABLE_WALK_RUN_ANI_ALTERNATIVE			// alternatif kosma animasyonu
#define ENABLE_SIMPLE_REFINED_EFFECT_CHECK			// basit efekt kontrolu
#define USE_RELATIVE_PATH						// goreceli dosya yollari
#define USE_CRAMERS_RULE						// cramers rule matematik
#define ENABLE_LOAD_ITEM_LIST_FROM_ROOT			// item_list'i root'tan oku
#define ENABLE_LOAD_ITEM_SCALE_FROM_ROOT			// item_scale'i root'tan oku
#define ENABLE_LOAD_SKILL_TABLE_FROM_ROOT			// skill_table'i root'tan oku
#define ENABLE_LOAD_ALTER_ITEMICON				// itemicon'u root'tan oku
#define ENABLE_ATLASINFO_FROM_ROOT				// atlasinfo'yu root'tan oku
#define ENABLE_NPC_WITHOUT_COLLISIONS				// npc carpisma yok
#define ENABLE_PETS_WITHOUT_COLLISIONS				// pet carpisma yok
#define ENABLE_SHOPS_WITHOUT_COLLISIONS				// dukkan carpisma yok
#define ENABLE_MOUNTS_WITHOUT_COLLISIONS			// binek carpisma yok
//
// --- Login / parametre ---
#define SCREENSHOT_CWDSAVE					// ekran goruntusu cwd kaydet
#define SKIP_LOGIN_PHASE					// loginInfo.xml varsa auto-login (intrologin loginInfo=False bugi duzeltildi)
#define SKIP_LOGIN_PHASE_SUPPORT_CHANNEL			// skip-login kanal destegi
#define FULL_BACK_IMAGE						// login tam ekran arkaplan
#define SELECT_CHAR_NO_DELAY 0.5					// karakter secim bekleme suresi
#define LOGIN_DELAY_SEC 0.0f					// login gecikme suresi
#define SUB2_LOADING_ENABLE 1					// alt yukleme ekrani
#define EXPANDED_COMBO_ENABLE 1					// genisletilmis combo
#define CONVERT_EMPIRE_LANGUAGE_ENABLE 0			// krallik dili cevirisi
#define MINIMAP_POSITIONINFO_ENABLE 1				// minimap konum bilgisi
#define CHRNAME_COLOR_INDEX 0					// isim renk indeksi
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Karakter ve Oyuncu ###
// Karakter yuvasi 4. pid5 acilmaz.
// #define ENABLE_PLAYER_PER_ACCOUNT5
// #define ENABLE_LEVEL_IN_TRADE
// #define ENABLE_RACE_HEIGHT
// #define ENABLE_GM_FLAG_FOR_LOW_WIZARD
// #define ENABLE_CANSEEHIDDENTHING_FOR_GM
// #define ENABLE_STATPLUS_NOLIMIT
// #define ENABLE_SET_STATE_WITH_TARGET
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
// #define ENABLE_SKILL_FLAG_PARTY
// #define ENABLE_ELEMENTAL_TARGET
// #define ENABLE_NULLIFYAFFECT_LIMIT
// #define ENABLE_MASTER_SKILLBOOK_NO_STEPS
// #define ENABLE_IMMUNE_PERC
// #define ENABLE_NO_DAMAGE_QUEST_RUNNING
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
// #define ENABLE_FIREWORK_STUN
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
// #define ENABLE_NO_SELL_PRICE_DIVIDED_BY_5
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
// #define ENABLE_WON_EXCHANGE_WINDOW
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Lonca ve Sosyal ###
// #define ENABLE_D_NJGUILD
// #define ENABLE_NEWGUILDMAKE
// #define ENABLE_PARTYKILL
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Sohbet ###
// #define ENABLE_CHAT_COLOR_SYSTEM
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
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Harita, Dunya ve Toplayicilik ###
enum eCommonDefines {
	MAP_ALLOW_LIMIT = 32, // 32 default
};
// #define ENABLE_MOVE_CHANNEL
// #define ENABLE_REDUCED_ENTITY_VIEW
// #define ENABLE_CMD_WARP_IN_DUNGEON
// #define ENABLE_FISHINGROD_RENEWAL
// #define ENABLE_PICKAXE_RENEWAL
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Istemci Arayuz ve Gorsel ###
// CONQUEROR sistemi kaldirildi
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### GM ve Debug ###
#define ENABLE_GENERAL_CMD					// ek GENERAL_CMD dosyalari varsa yukler (yoksa no-op)
#define ENABLE_GENERAL_CONFIG					// ek GENERAL_* config dosyalari varsa yukler (yoksa no-op)
#define ENABLE_GOOGLE_TEST					// unittest modu (Windows'ta derleme-korumali, no-op)
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Pack/Python Ayarlari ###
// Buradaki tum tanimlar derleme sirasinda app.X olarak python'a aktarilir.
// Aktif: #define X / #define X <deger>   Kapali: // #define X

// #define ENABLE_NEW_LEVELSKILL_SYSTEM    // 5 (B,M,G,P,F) beceri .mse yukler
// #define EXTRA_UI_FEATURE                  // ekstra ui ozellikleri
// #define NEW_678TH_SKILL_ENABLE            // 6. savasci/ninja becerileri
// #define ENABLE_ACTIVE_PET_SEAL_EFFECT     // pet muhru aktif efekti
#define ENABLE_SAVE_ACCOUNT               // hesap kaydetme
// #define DISABLE_GUILD_SKILL             // lonca becerisi kapali
// #define DISABLE_DECLARE_WAR             // savas ilani kapali
// #define ENABLE_DRAGON_GATE              // pack ui scriptleri (app.X sorgusu)
// #define ENABLE_MERCENARY_SYSTEM
// #define ENABLE_SUNGMAHEE_GATE
// #define ENABLE_ADDITIONAL_EQUIPMENT_PAGE
// #define ENABLE_PREMIUM_PRIVATE_SHOP
// #define ENABLE_AUTO_SYSTEM

// --- Degerli ayarlar (python'a aynen aktarilir; kapatmak icin silme, degeri degistir) ---
// #define IN_GAME_SHOP_ENABLE 1
// #define CONSOLE_ENABLE 0
// #define PVPMODE_ENABLE 1
// #define PVPMODE_TEST_ENABLE 0
// #define PVPMODE_ACCELKEY_ENABLE 1
// #define PVPMODE_ACCELKEY_DELAY 0.5f
// #define PVPMODE_PROTECTED_LEVEL 15
// #define HIGH_PRICE 500000
// #define MIDDLE_PRICE 50000
// #define ERROR_METIN_STONE 28960
// #define USE_ITEM_WEAPON_TABLE_ATTACK_BONUS 0
// #define ADD_DEF_BONUS_ENABLE 0
// #define LOGIN_COUNT_LIMIT_ENABLE 0
// #define USE_SKILL_EFFECT_UPGRADE_ENABLE 1
// #define GUILD_MONEY_PER_GSP 100
// #define GUILD_WAR_TYPE_SELECT_ENABLE 1
// #define TWO_HANDED_WEAPON_ATT_SPEED_DECREASE_VALUE 10

#endif // __INC_METIN2_CONTROLS_H__
