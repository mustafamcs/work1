# work1 bilgi

Bu dosya `C:\Works\work1` ürün ağacının güncel durumunu özetler. Plan kaynağı `C:\Works\work1-kaynak\plan` (13 dosya, `00-okuma-sirasi.md` → `13-yedek-operasyon.md`).

## Dizin özeti

- **client:** `metin2client.exe`, DLL'ler, `pack` (26 eix/epk çifti + `PackMakerLite.exe`; `yw_pc3` kurtadam paketi plan gereği çıkarıldı ve `Index`'ten silindi), `locale.cfg` (`10002 65001 tr`), `locale_list.txt` (**2 dil: `Turkish 65001 tr` + `English 1252 en`** — login'deki dil seçimi bu dosyadan okunur), `loca.cfg` (seçili dil), `channel.inf` (son seçim).
- **Srcs\Pack:** Açılmış paket ağaçları; değiştirilen paketler PackMakerLite ile yeniden paketlenip `client\pack`'e yazıldı. `client\pack\_yedek\` silindi (eski sürümler git geçmişinde). **Dil temizliği:** `locale/locale/` 17 dilden `en`+`tr`'ye indi, `special_patch_maliml/locale/` aynı şekilde, `special_patch_ex/locale/` yalnız `common` kaldı. `uiscriptlocale.py`'deki iki `LOCALE_NAME_DICT` `en`/`tr`/`eu`-anonymous'a indirildi; `Locale.cpp`'de diğer servis dalları ve `gs_stLocaleData` tablosu `en`/`tr`'ye budandı, varsayılan `ymir`→`tr` (cp 65001). `IsARABIC`/`IsBRAZIL` vb. çalışma-anı kontrolleri artık hep False döner (ölü dallar bırakıldı — silinen `locale/ae` görsellerine referans veren iki dal temizlendi).
- **server:** `auth`, `channel1` (şimdilik tek `core1`), `channel99`, `db`, `profiles` (`99`,`105`,`120`), `share` (`bin`, `locale\turkey`), `_operator.txt`. Süreçler `tools\script` betikleriyle yönetilir (her dizinde `game.exe`/`db.exe` + `CONFIG`/`conf.txt` + `CMD`).
- **sql:** `schema.sql`, `import-windows.bat`, `IMPORT-NOT.md`, `dumps` (eski `srv1_*` dökümleri; plan-dışı kolonlar taşınmaz — `IMPORT-NOT.md`).
- **Srcs:** `Client`, `Server` (`common`, `db`, `game`, `libgame`, `liblua`, `libpoly`, `libsql`, `libthecore`, `platform`, CMake ağacı, `server.sln`), `Tools`, `Pack`, `Extern`, `Metin2.sln`. `Srcs\Server\game\game_41078` 87MB FreeBSD i386 ELF referans binary olarak duruyor.
- **panel/launcher/control:** kullanıcı kararıyla **tamamen kaldırıldı** (CI4 PHP paneli, `sql\panel.sql`, `Srcs\Server\control`, `Srcs\Server\launcher`, `server\control.exe`, `launcher\`, `out\control`, `out\launcher`). `server.sln` artık yalnız lib'ler + `db`/`game`/`qc` derliyor.
- **tools:** `packmakerlite`, `utf8_donustur.py` (tum metin dosyalarini UTF-8 e donusturur; cp949/cp1254 tespiti, 87_ betigi), **`script\` — işletim betikleri**: her iş ayrı `.bat` (`tools\script\README.md`). Süreç açma/kapama/durum (`10_`–`33_`), derleme+dağıtım (`40_`–`44_`), quest derleme (`50_`), profil geçişi (`60_`–`62_`), istemci/pack/sql (`70_`–`73_`). Ortak yollar `_ayar.bat`'ta. `_gizli_baslat.vbs` süreçleri penceresiz başlatır; `_gizli.vbs <betik>` betiğin kendisini tamamen penceresiz çalıştırıp `log\` altına yazar. Derleme betikleri önce açık çıktıyı kapatır (port/taskkill), sonra `out\`'dan kullanıldığı dizinlere kopyalar.
- **wiki:** kullanıcı kararıyla **tamamen kaldırıldı** (`wiki\` ve `tools\wiki-uret`).
- **out:** derleme çıktıları (`game`, `db`, `qc`, `client`).
- **active_profile:** kökte, değer `99`.

## Profiller

`server\profiles\<id>\profile.conf`. `exp_mul`, `drop_mul`, `gold_mul` üçünde de boş (açık karar).

| Profil | level_cap | attr_slots | map_allow |
| --- | --- | --- | --- |
| 99 | 99 | 5 | 34 index |
| 105 | 105 | 5 | 44 index (99 + `301-304 216 217 351 364 352 367`) |
| 120 | 120 | 7 | 49 index (105 + `210 212 355 356 358`) |

`map_allow` kümülatif: 99 ⊂ 105 ⊂ 120. Tüm indexler `map/index`'te var (74 satır).

## Portlar ve MAP_ALLOW dilimleri

| Süreç | PORT | P2P_PORT |
| --- | --- | --- |
| db | 30000 (`BIND_PORT`) | — |
| auth | 30001 | 30002 |
| channelN coreM | 30003 + (N-1)·20 + (M-1)·2 (örn. ch1/core1=30003, ch4/core6=30073) | PORT+1 |
| channel99 | 30901 | 30902 |

Harita dilim tablosu core başına sabittir: core1 `1 21 41 4 24 44 250`, core2 `3 23 43`, core3 `64 63 61 65`, core4 `62 69 70 67 68 71 104 107 108 109`, core5 `217 301 302 303 304` (yalnız profil ≥105). **Çapa kuralı:** kanaldaki en küçük mevcut core, dizini olmayan core'ların dilimlerini üstlenir — şu an tek `core1` olduğundan 99 profilinde 24 index'in tamamı, ≥105'te 29 index `channel1\core1\CONFIG`'e yazılır; ileride `core2` vb. eklendikçe dilimler kendiliğinden geri dağılır. channel99 (oyuncuya listelenmez): 99'da `66 72 73 208 81 112 113 181 182 183`; ≥105'te `+216 351 352 364 367`; 120'de `+210 212 355 356 358`.

`ADMINPAGE_PASSWORD` tüm CONFIG'lerde `server\_operator.txt` değeriyle aynı (`CHANGE_ME` kalmadı). `MAX_LEVEL` 120 — tavan çalışma anında profil tarafından kesilir. Her core'da `locale` → `..\share\locale\turkey` junction'ı; tek fiziksel locale kopyası `share\locale`.

## Kilit motoru (uygulandı)

- `common\profile.h`: `active_profile` + `profile.conf` okuma; `ProfileComputeLock` (öncelik 2→1→3→0: sistem kapalı → `min_profile` → nadir-efsun yuvası); `ProfileIsItemUsable`; donmuş karakter (`m_bFrozen`) bayrakları.
- `TPlayerItem.profile_lock` ve `TItemTable.wMinProfile` paylaşık yapıda; db üç item SELECT'ine dahil.
- Kapılar: kuşanma/kullanım/düşürme/takas/dükkan/ikarus satırlarında kilit reddi; 99/105'te 5, 120'de 7 efsun; seviye tavanı üstü karakter donar (saldırı/exp/para alışverişi kapalı), kayıtlı seviye silinmez.
- `item_proto.txt`'e `MIN_PROFILE` kolonu eklendi: kemer/kostüm/mühürlü pet/blend → 105 (2280 satır), DS/ACCE/aura/levelli pet/tılsım/soulitem + range satırları → 120 (1389+180). 80 `ARMOR_GLOVE` satırı silindi (plan: eldiven yok).
- Lycan/wolfman tamamen çıkarıldı (plan 01: "`ANTI_WOLFMAN` diske yazılmaz"): 4.169 satırdan `ANTI_WOLFMAN` bayrağı silindi; 162 `WEAPON_CLAW`, 72 lycan-efsunlu eşya, 352 dört-sınıfa-kapalı lycan ekipmanı, lycan pet/kutu/kitap satırları (`53268/53269/53567/53568/39044/39045/31208/31213/54041/54042/55014`) toplam ~600 satır item_proto'dan atıldı; `mob_proto`'dan 10 wolfman yaratığı (4505, 20400–20405, 34100–34102); `item_names`/`mob_names`/17 dil `itemdesc`/`item_list`/`locale_quest`/`npclist`/`ori_to_new` temizlendi; `dragon_soul_table`'daki yorumlu WOLFMAN bonusları ve pvp_arena `npc.txt`'teki 20400 spawn'ı kaldırıldı; model klasörleri (`yw_npc/wolfman_*`, `yw_monster2/secret_wolfman`, `npc_pet/worldcup_2018_wolfman`, `special_patch_hair/pc3`, `sound/monster2/secret_wolfman`) silindi.
- GM komutu `do_profile_recalc` tüm karakterlerin kilit + dondurma durumunu yeniden hesaplar.

## Profil geçişi (control kaldırıldıktan sonra)

`tools\script\60_profil_99.bat` / `61_profil_105.bat` / `62_profil_120.bat` otomatik yapar; elle yapılırsa:

Profil değişimi elle yapılır: `active_profile` dosyasına `99|105|120` yazılır; `server\channel1\core1\CONFIG` içindeki `MAP_ALLOW` satırı profile göre güncellenir — 99'da `1 21 41 4 24 44 250 3 23 43 64 63 61 65 62 69 70 67 68 71 104 107 108 109` (24 index), ≥105'te sona `217 301 302 303 304` eklenir; `server\channel99\CONFIG` 99'da `66 72 73 208 81 112 113 181 182 183`, ≥105'te `+216 351 352 364 367`, 120'de `+210 212 355 356 358`. `db.exe` `lock_recalc.sql`/`profile_lock` mantığını çalışma anında kilit motoruyla uygular.

## İstemci / Pack

- `serverinfo.py` (Srcs\Pack\root): sunucu `MCS`, auth `30001`, **tek oyuncu kanalı** CH-1 (`30003`); CH-2..4 satırları yorumda hazır (30023/30043/30063), CH-99 yorumda, listelenmez.
- won/cheque UI temizlendi: `uiwonexchange*.py`, cheque uiscript pencereleri silindi; exchange/shop/inventory/guild/tooltip wiring'i kaldırıldı; `special_patch_ex` locale'den 27 won-anahtarı silindi.
- wolfman/lycan temizlendi: `wolfman_m.msm`, `pc3` saç/sound paketleri, race-8 referansları, `Genel.lycan` panel anahtarı; `playersettingmodule - Kopya.py` silindi.
- Tüm `item_list.txt`'lerden 80 eldiven ikon satırı silindi (vnum 23000–23089).
- `costumewindow1.py` onarıldı: iç-içe `if ENABLE_ACCE_COSTUME_SYSTEM` dalı geri kondu (hazır IndentationError'du); 4 kopya da py2-derleme temiz.
- Quest ağacı: wolfman/lycan/yohara/cheque taraması 0 eşleşme (`globals.lua`, `questlib_extra.lua`, `give_basic_weapon`, `book_packs`, `quest_functions` temiz; `give_basic_weapon` qc ile yeniden derlendi).
- `icon` paketinden 8 eldiven TGA'sı (23000–23080) silindi.
- Yeniden paketlenenler unpack ile doğrulandı: `locale`, `root` (serverinfo yorumları korunuyor), `special_patch_ex` (won-anahtarları yok). Canlı istemci çalıştırma testi yapılmadı.

## SQL

`schema.sql`: `account`/`player`/`common`/`log` + `hotbackup`; `item.profile_lock`, `item_proto.min_profile`, `schema_version=1`, `exp_table` 120'ye kadar, `player.exp int unsigned`, `gold bigint`, `pid1..pid4`, 7 efsun çifti, `item.window` içinde `PET`. db binary proto/shop/skill tablolarını `player` şemasında aradığı için orada uyumlu kopyalar var — `IMPORT-NOT.md` senkron notunu yazar. `player` şemasında ayrıca içerik tabloları var (`biolog_info`, `drop_default`, `drop_mob_group/item_level/kill`, `itemshop_category/item`, `fateroulette`, `fishevent_items`).

## Derleme

MSBuild v143. `Srcs\Server\server.sln` + `Srcs\Metin2.sln`; ayrıca `Srcs\Server\CMakeLists.txt` + `platform\` katmanı (win/freebsd) plan 07'ye göre eklendi (`/utf-8`, `/Zc:preprocessor`, C++20). `log.h` ve 15 questlua dosyası `__VA_OPT__`'a taşındı. Derlenenler: `out\game\Release\game.exe`, `out\db\Release\db.exe`, `out\qc\Release\qc.exe`, `out\client\...\metin2client.exe`. Binary'ler tüm süreç dizinlerine kopyalandı.

## Bilinen eksikler / açık işler

- `exp_mul`, `drop_mul`, `gold_mul` üç profilde de boş — plan'ın açık kararları.
- Eix/epk'ler yeniden paketlendi ama canlı istemci çalıştırma testi yapılmadı.
- Güncel şema canlı MariaDB'ye bu ortamda içe aktarılmadı (mysql istemcisi yok); `sql\import-windows.bat` + `IMPORT-NOT.md` sırayı yazar.
- `srv1_*` eski dökümler içe aktarılmadı; `cheque`/`glove`/wolfman kolonları taşınmamalı (`IMPORT-NOT.md`).
- Kaynakta autohunt/aura/gaya/transmutation/buffi implementasyonu yok — feature bayrakları durur, içerik doğmaz; Büyülü Orman haritası pack'te yok.
- ~7.800 regen vnum'u pack'in kırpılmış mob_proto'sunda yok (gerçek veri açığı).
- FreeBSD hedefi: kaynak/CMake hazır, FreeBSD'de derleme bu Windows ortamında denenmedi.
- Sunucu süreçleri `tools\script` ile yönetiliyor: `30_hepsini_baslat.bat` sırayla mariadb → db → auth → core1.1 → ch99 açar, `31_hepsini_durdur.bat` tersini yapar, `33_durum.bat` portlara göre durumu gösterir. Gizli çalıştırma: `wscript _gizli.vbs <betik.bat>`.

## Git

- Dal `main`, origin `https://github.com/mustafamcs/work1.git`. Çalışma ağacı bu turda çok değişti (yüzlerce dosya). Commit/push yapılmadı.
