-- Yapisal oyun verileri icin jenerik satir tablosu.
-- Dosya tabanli tablolar (group.txt, cube.txt, fishing.txt vb.) JSON
-- icerikleriyle birebir token-satiri olarak tutulur:
--   src : kaynak dosya adi (uzantisiz), ornegin 'group', 'cube'
--   seq : dosya icindeki satir sirasi (0'dan baslar)
--   k   : ilk token (bos birakilamaz; bos satirlar tutulmaz)
--   c1..c24 : kalan tokenlar; kisa satirlarin kalan hucreleri NULL'dir
--
-- game.exe acilis/belirirken tabloyu DirectQuery ile okur ve mevcut
-- token-tabanli parser'lara ayni satir dizisini besler. Tabloda src
-- icin satir yoksa JSON/TXT dosya fallback'i devreye girer.

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS `game_data_row` (
  `src` varchar(64) NOT NULL,
  `seq` int(11) NOT NULL,
  `k` varbinary(255) NOT NULL,
  `c1` varbinary(255) DEFAULT NULL,
  `c2` varbinary(255) DEFAULT NULL,
  `c3` varbinary(255) DEFAULT NULL,
  `c4` varbinary(255) DEFAULT NULL,
  `c5` varbinary(255) DEFAULT NULL,
  `c6` varbinary(255) DEFAULT NULL,
  `c7` varbinary(255) DEFAULT NULL,
  `c8` varbinary(255) DEFAULT NULL,
  `c9` varbinary(255) DEFAULT NULL,
  `c10` varbinary(255) DEFAULT NULL,
  `c11` varbinary(255) DEFAULT NULL,
  `c12` varbinary(255) DEFAULT NULL,
  `c13` varbinary(255) DEFAULT NULL,
  `c14` varbinary(255) DEFAULT NULL,
  `c15` varbinary(255) DEFAULT NULL,
  `c16` varbinary(255) DEFAULT NULL,
  `c17` varbinary(255) DEFAULT NULL,
  `c18` varbinary(255) DEFAULT NULL,
  `c19` varbinary(255) DEFAULT NULL,
  `c20` varbinary(255) DEFAULT NULL,
  `c21` varbinary(255) DEFAULT NULL,
  `c22` varbinary(255) DEFAULT NULL,
  `c23` varbinary(255) DEFAULT NULL,
  `c24` varbinary(255) DEFAULT NULL,
  PRIMARY KEY (`src`,`seq`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- SQL'den beslenen kaynaklarin kayit listesi.
-- Bir src burada varsa game_data_row otoriterdir (0 satir bile olsa);
-- yoksa loader dosya fallback'ine duser.
CREATE TABLE IF NOT EXISTS `game_data_src` (
  `src` varchar(64) NOT NULL,
  PRIMARY KEY (`src`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
