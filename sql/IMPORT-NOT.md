# Import notu (work1)

## Sira

1. `schema.sql` — `account`, `player`, `common`, `log` ve `hotbackup` veritabanlarini olusturur. Tum `DROP TABLE` satirlari icerir; tekrar calistirmak tablolari SIFIRLAR.

Windows'ta: `sql\import-windows.bat [kullanici] [host] [port] [mysql.exe-yolu]` — parola betikte sakli degildir, calisinca sorulur.

## hotbackup

- `schema.sql` sonunda `CREATE DATABASE IF NOT EXISTS hotbackup` vardir; tablo YOKTUR.
- DB binary `hb_YYMMDDHH_player` tablolarini calisma sirasinda kendisi acar (`Srcs\Server\db\src\HB.cpp`: `SHOW CREATE TABLE player` + `CREATE TABLE IF NOT EXISTS`). `conf.txt` icinde `SQL_HOTBACKUP` satiri bu DB'ye isaret eder; su an `DISABLE_HOTBACKUP = 1` oldugundan ozellik kapali.
- `REPLACE INTO hb_... SELECT * FROM player.player` sorgusu SQL_HOTBACKUP baglantisi uzerinden kosar; `work1` kullanicisinin hem `hotbackup` hem `player` uzerinde yetkisi olmali (pratikte tum DB'ler icin tek kullanici yetkilendirin).

## Proto tablolari iki yerde (bilincli)

- Plan/panel icin kanonik kopya: `common.item_proto|mob_proto|shop|shop_item|refine_proto|item_attr|item_attr_rare|skill_proto`.
- DB binary ayni tablolari `player` DB'sinde arar: `DirectQuery` varsayilan slot `SQL_PLAYER` (`Srcs\Server\db\src\ClientManagerBoot.cpp`; `conf.txt` `PROTO_FROM_DB=0`, `MIRROR2DB=1`). `schema.sql` dosya sonunda bu tablolari `CREATE TABLE player.X LIKE common.X` ile kopyalar.
- Veri doldururken (proto import / dump) IKI kopyayi da besleyin ya da senkron tutun; `common` kopyasi plan araclari, `player` kopyasi oyun binarysi tarafindan okunur.

## Icerik satirlari (boot icin kritik)

`schema.sql` bilerek icerik satiri tasimaz. DB binary boot'ta asagidaki tablolari `player` DB'sinden okur ve BOS ise hata verip cikar:

- `shop` / `shop_item` ("InitializeShopTable : Table count is zero.")
- `item_attr` ("no result from item_attr")
- `item_attr_rare` ("no result from item_attr_rare")
- `skill_proto` ("no result from skill_proto")

Bu tablolar acilmadan once icine gercek veri koyun (asagidaki eski dump'lar ya da proto araclari). `refine_proto` bos olsa da db acilir; `item_proto`/`mob_proto` txt'den yuklenip `player` kopyasina aynalanir (MIRROR2DB).

`item_attr`/`item_attr_rare` `apply` enum'unda `RESERVED_94/95/96/114` yer tutuculari, `apply+0` indekslerinin binary APPLY numaralariyla (97=ACCEDRAIN_RATE, 99=ENCHANT_ELECT, 118=MOUNT) hizali kalmasi icindir — silmeyin.

`item.window` enum sirasi binary `EWindows` ile birebir (INVENTORY=1 ... IKASHOP_AUCTION=10); `COSTUME/ACCE/AURA/TALISMAN/PET` (11-15) binary'nin su an gondermedigi ileri uyumluluk degerleridir — enum'un basina/ortasina uyeler eklemeyin.

## dumps\ icindeki srv1_* dosyalari

Eski sunucu dump'lari; plan disi eski DB adlarini kullanir — DUZENLEMEYIN.

| Dosya | Eski DB | Plan DB |
|---|---|---|
| srv1_account.sql | srv1_account | account |
| srv1_player.sql | srv1_player | player (proto tablolari + veri icerir) |
| srv1_common.sql | srv1_common | common |
| srv1_log.sql | srv1_log | log |
| srv1_hotbackup.sql | srv1_hotbackup | hotbackup (bos dump) |

`CREATE DATABASE`/tablo adlari `srv1_*` oneklidir; iceri alacaksaniz once `srv1_` oneklerini kaldirin ya da satir verilerini (`INSERT INTO`) hedef DB'lere el ile tasi yin. `srv1_player.sql` icindeki `item_proto` (11k satir), `mob_proto` (2.8k), `shop` (33), `skill_proto` (97), `item_attr` (53), `item_attr_rare` (20) satirlari yukaridaki "icerik satirlari" ihtiyacini karsilar. Dikkat: dump `latin1` ve `cheque`/`glove` kolonlari icerir — plan disi kolonlari tasimayin. (Wolfman/lycan verileri ve `item_attr_wolfman` tablosu bu dumptan temizlendi.)

## Panel kullanici yetkileri

(Panel/launcher/control katmani kullanici karariyla kaldirildi; bu bolum yalniz tarihsel referans olarak duruyor.)
