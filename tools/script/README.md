# tools\script — work1 işletim betikleri

Her iş için ayrı `.bat` dosyası. `cmd.exe` ile çalışır, ek bağımlılık yok.
Tüm yollar `_ayar.bat` içindedir — taşıma durumunda sadece orayı düzenle.

## Gizli (penceresiz) çalıştırma

İki yardımcı VBS var:

- **`_gizli_baslat.vbs`** — betiklerin içinden süreçleri penceresiz başlatır.
  db/game/mariadbd hiçbir konsol penceresi açmadan arka planda çalışır.
- **`_gizli.vbs <betik.bat> [arg]`** — herhangi bir betiği **tamamen
  penceresiz** çalıştırır; çıktı `tools\script\log\<betik>.log`'a yazılır.
  Örn. `wscript _gizli.vbs 30_hepsini_baslat.bat` — hiçbir pencere açılmaz.

`.bat` dosyasına çift tıklanırsa kendi konsolu kısa süre görünür; hiç
pencere istemiyorsan `_gizli.vbs` üzerinden çağır (veya ona kısayol koy).

## Yönetici yetkisi (UAC)

Tüm betikler **yönetici yetkisi gerektirir**. Admin değilse betik kendini
`_admin.vbs` üzerinden `runas` ile yeniden başlatır — sadece UAC onayı
görünür, betik penceresiz ve yükseltilmiş çalışır. Argümanlar korunur
(`71_paket_repack root` gibi). `_ayar.bat` bir kütüphane olduğu için
kontrol içermez.

## Artık süreç temizliği

- **`_artik_kapat.bat`** — derleme/araç artıklarını kapatır (`MSBuild`,
  `cl`, `link`, `mspdbsrv`, `VBCSCompiler`, `vctip`, `tracker`,
  `PackMakerLite`, `DumpProto`). Oyun süreçlerine dokunmaz.
- Tüm derleme (40–44, 84) ve repack (71, 80, 81) betikleri iş bitince
  bunu otomatik çağırır; `85_zorla_kapat` da çağırır.
- MSBuild çağrılarında `/nr:false` var — node-reuse sayesinde derleme
  sonrası açık kalan `MSBuild.exe` işçileri artık oluşmaz.

## Süreç açma/kapama (bağımlılık sırasıyla)

| Betik | İş |
|---|---|
| `10_mariadb_baslat.bat` | MariaDB'yi süreç olarak başlatır (servis değil, admin gerekmez) |
| `11_mariadb_durdur.bat` | Önce `mysqladmin shutdown`, yetmezse süreç kapatma |
| `20_db_baslat.bat` / `21_db_durdur.bat` | `server\db` (db.exe, :30000) |
| `22_auth_baslat.bat` / `23_auth_durdur.bat` | `server\auth` (game.exe, :30001) |
| `24_core_baslat.bat` / `25_core_durdur.bat` | `server\channel1\core1` (game.exe, :30003) |
| `26_ch99_baslat.bat` / `27_ch99_durdur.bat` | `server\channel99` (game.exe, :30901) |
| `30_hepsini_baslat.bat` | mariadb → db → auth → core → ch99 |
| `31_hepsini_durdur.bat` | ters sırada hepsini kapatır |
| `32_hepsini_yeniden.bat` | durdur + başlat |
| `33_durum.bat` | portlara göre süreç durum tablosu + aktif profil |
| `34_sunucu_istemci_baslat.bat` | hepsini başlat + istemciyi aç |

Her başlatma betiği port zaten dinleniyorsa "zaten açık" der ve çıkar;
bağımlı katman kapalıysa önce onu zincirler (`24_core` → db → mariadb).

## Derleme (önce açık çıktı kapatılır, sonra kullanıldığı yere dağıtılır)

| Betik | Önce kapatır | Dağıtım |
|---|---|---|
| `40_build_db.bat` | db :30000 | `server\db`, `share\bin` |
| `41_build_game.bat` | auth/core1/ch99 | `auth`, `channel1\core1`, `channel99`, `share\bin` |
| `42_build_qc.bat` | qc.exe | `quest\`, `share\bin` |
| `43_build_hepsi.bat` | hepsi | yukarıdakilerin tümü |
| `44_build_client.bat` | metin2client.exe | `client\metin2client.exe` |
| `84_tam_derleme.bat` | tümü | `out\` silinir, `Metin2.sln` 27 proje sıfırdan derlenir, tüm çıktılar dağıtılır |

## Quest

`50_quest_derle.bat` — `quest_list`'teki her `.quest` dosyasını `qc.exe`
ile derler; sonunda derlenen/hata sayısını verir.

## Profil geçişi (99 / 105 / 120)

`60_profil_99.bat`, `61_profil_105.bat`, `62_profil_120.bat`

Oyun süreçlerini durdurur (MariaDB açık kalır), `active_profile` yazar,
`core1` ve `ch99` CONFIG'lerindeki `MAP_ALLOW` satırlarını profile göre
yeniler ve süreçleri geri başlatır.

## Diğer

| Betik | İş |
|---|---|
| `70_istemci_baslat.bat` | `client\metin2client.exe` — görünür pencere |
| `71_paket_repack.bat <paket>` | istemciyi kapatır, `Srcs\Pack\<paket>` → PackMakerLite → `client\pack\`, artık dosya bırakmaz |
| `73_sql_import.bat` | `sql\schema.sql` içe aktarımı (mariadb açık olmalı) |
| `80_hepsi_repack.bat` | `Srcs\Pack` altındaki **tüm** paketleri sırayla repack eder |
| `81_dil_temizle.bat` | locale dizinlerinde en/tr/common dışını siler, değişen paketleri repack eder |
| `82_temizle.bat` | syserr/syslog/log, `_yedek`, `.pre_qc`, `__pycache__`, `*.bak/*~` artıklarını temizler |
| `83_kapat_ve_temizle.bat` | hepsini durdur + istemciyi kapat + `82_temizle` |
| `85_zorla_kapat.bat` | tüm süreçleri imaj adından zorla kapatır (acil durum) |
| `86_dogrula.bat` | binary varlığı + aktif profil ↔ MAP_ALLOW uyumu + dil dizini + port kontrolü |

## Tipik akışlar

```
wscript _gizli.vbs 30_hepsini_baslat.bat   REM sunucuyu sessizce ac
33_durum.bat                               REM durumu gor
61_profil_105.bat                          REM midschool profiline gec
43_build_hepsi.bat                         REM derle + dagit
wscript _gizli.vbs 31_hepsini_durdur.bat   REM hepsini sessizce kapat
```
