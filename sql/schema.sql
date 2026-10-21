-- Game schema. One file, four databases. Profiles 99, 105 and 120 share it.
-- Empty of accounts, players, items and GM rows.
-- Reference rows: common.exp_table 1-120, common.locale (LOCALE = turkey).

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS `account` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `account`;

-- GameTime
DROP TABLE IF EXISTS `GameTime`;
CREATE TABLE `GameTime`  (
  `UserID` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `paymenttype` tinyint(2) NOT NULL DEFAULT 1,
  `LimitTime` int(11) UNSIGNED NULL DEFAULT 0,
  `LimitDt` datetime NULL DEFAULT current_timestamp(),
  `Scores` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`UserID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- GameTimeIP
DROP TABLE IF EXISTS `GameTimeIP`;
CREATE TABLE `GameTimeIP`  (
  `ipid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '000.000.000.000',
  `startIP` int(11) NOT NULL DEFAULT 0,
  `endIP` int(11) NOT NULL DEFAULT 255,
  `paymenttype` tinyint(2) NOT NULL DEFAULT 1,
  `LimitTime` int(11) NOT NULL DEFAULT 0,
  `LimitDt` datetime NOT NULL DEFAULT current_timestamp(),
  `readme` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ipid`) USING BTREE,
  UNIQUE INDEX `ip_uniq`(`ip` ASC, `startIP` ASC, `endIP` ASC) USING BTREE,
  INDEX `ip_idx`(`ip` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- GameTimeLog
DROP TABLE IF EXISTS `GameTimeLog`;
CREATE TABLE `GameTimeLog`  (
  `login` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `type` enum('IP_FREE','FREE','IP_TIME','IP_DAY','TIME','DAY') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `logon_time` datetime NOT NULL DEFAULT current_timestamp(),
  `logout_time` datetime NOT NULL DEFAULT current_timestamp(),
  `use_time` int(11) UNSIGNED NULL DEFAULT NULL,
  `ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '000.000.000.000',
  `server` varchar(56) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  INDEX `login_key`(`login` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- account
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'LOGIN_MAX_LEN=30',
  `password` varchar(42) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'PASSWD_MAX_LEN=16; default 45 size',
  `social_id` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `securitycode` varchar(192) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `status` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'OK',
  `availDt` datetime NOT NULL DEFAULT current_timestamp(),
  `create_time` datetime NOT NULL DEFAULT current_timestamp(),
  `last_play` datetime NOT NULL DEFAULT current_timestamp(),
  `gold_expire` datetime NOT NULL DEFAULT current_timestamp(),
  `silver_expire` datetime NOT NULL DEFAULT current_timestamp(),
  `safebox_expire` datetime NOT NULL DEFAULT current_timestamp(),
  `autoloot_expire` datetime NOT NULL DEFAULT current_timestamp(),
  `fish_mind_expire` datetime NOT NULL DEFAULT current_timestamp(),
  `marriage_fast_expire` datetime NOT NULL DEFAULT current_timestamp(),
  `money_drop_rate_expire` datetime NOT NULL DEFAULT current_timestamp(),
  `real_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `question1` varchar(56) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `answer1` varchar(56) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `question2` varchar(56) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `answer2` varchar(56) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cash` int(11) NULL DEFAULT 0,
  `mileage` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `login`(`login` ASC) USING BTREE,
  INDEX `social_id`(`social_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- block_exception
DROP TABLE IF EXISTS `block_exception`;
CREATE TABLE `block_exception`  (
  `login` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ''
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- iptocountry
DROP TABLE IF EXISTS `iptocountry`;
CREATE TABLE `iptocountry`  (
  `IP_FROM` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `IP_TO` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `COUNTRY_NAME` varchar(56) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- string
DROP TABLE IF EXISTS `string`;
CREATE TABLE `string`  (
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

CREATE DATABASE IF NOT EXISTS `player` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `player`;

-- affect
DROP TABLE IF EXISTS `affect`;
CREATE TABLE `affect`  (
  `dwPID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `bType` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `bApplyOn` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `lApplyValue` int(11) NOT NULL DEFAULT 0,
  `dwFlag` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `lDuration` int(11) NOT NULL DEFAULT 0,
  `lSPCost` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`dwPID`, `bType`, `bApplyOn`, `lApplyValue`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- banword
DROP TABLE IF EXISTS `banword`;
CREATE TABLE `banword`  (
  `word` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`word`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- guild
DROP TABLE IF EXISTS `guild`;
CREATE TABLE `guild`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'snprintf(12u)',
  `sp` smallint(6) NOT NULL DEFAULT 1000,
  `master` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `level` tinyint(2) NULL DEFAULT NULL,
  `exp` int(11) NULL DEFAULT NULL,
  `skill_point` tinyint(2) NOT NULL DEFAULT 0,
  `skill` tinyblob NULL DEFAULT NULL,
  `win` int(11) NOT NULL DEFAULT 0,
  `draw` int(11) NOT NULL DEFAULT 0,
  `loss` int(11) NOT NULL DEFAULT 0,
  `ladder_point` int(11) NOT NULL DEFAULT 0,
  `gold` bigint(16) NULL DEFAULT NULL,
  `token` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- guild_comment
DROP TABLE IF EXISTS `guild_comment`;
CREATE TABLE `guild_comment`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `guild_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `notice` tinyint(4) NULL DEFAULT NULL,
  `content` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `aaa`(`notice` ASC, `id` ASC, `guild_id` ASC) USING BTREE,
  INDEX `guild_id`(`guild_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- guild_grade
DROP TABLE IF EXISTS `guild_grade`;
CREATE TABLE `guild_grade`  (
  `guild_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `grade` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'strlen(s) <= 12',
  `auth` set('ADD_MEMBER','REMOVE_MEMEBER','NOTICE','USE_SKILL') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`guild_id`, `grade`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- guild_member
DROP TABLE IF EXISTS `guild_member`;
CREATE TABLE `guild_member`  (
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `guild_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `grade` tinyint(2) NULL DEFAULT NULL,
  `is_general` tinyint(1) NOT NULL DEFAULT 0,
  `offer` int(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`guild_id`, `pid`) USING BTREE,
  UNIQUE INDEX `pid`(`pid` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- guild_war
DROP TABLE IF EXISTS `guild_war`;
CREATE TABLE `guild_war`  (
  `id_from` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `id_to` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_from`, `id_to`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- guild_war_bet
DROP TABLE IF EXISTS `guild_war_bet`;
CREATE TABLE `guild_war_bet`  (
  `login` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `gold` bigint(16) NULL DEFAULT NULL,
  `guild` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `war_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`war_id`, `login`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- guild_war_reservation
DROP TABLE IF EXISTS `guild_war_reservation`;
CREATE TABLE `guild_war_reservation`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `guild1` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `guild2` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `type` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `warprice` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `initscore` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `started` tinyint(1) NOT NULL DEFAULT 0,
  `bet_from` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `bet_to` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `winner` int(11) NOT NULL DEFAULT -1,
  `power1` int(11) NOT NULL DEFAULT 0,
  `power2` int(11) NOT NULL DEFAULT 0,
  `handicap` int(11) NOT NULL DEFAULT 0,
  `result1` int(11) NOT NULL DEFAULT 0,
  `result2` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- horse_name
DROP TABLE IF EXISTS `horse_name`;
CREATE TABLE `horse_name`  (
  `id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NONAME' COMMENT 'CHARACTER_NAME_MAX_LEN+1 so 24+null',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- ikashop_auction_offer
DROP TABLE IF EXISTS `ikashop_auction_offer`;
CREATE TABLE `ikashop_auction_offer`  (
  `seller` int(10) UNSIGNED NOT NULL,
  `buyer` int(10) UNSIGNED NOT NULL,
  `buyer_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` bigint(20) UNSIGNED NOT NULL,
  `datetime` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `seen` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`seller`, `buyer`, `price`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;
-- ikashop_notification
DROP TABLE IF EXISTS `ikashop_notification`;
CREATE TABLE `ikashop_notification`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `owner` int(10) UNSIGNED NOT NULL,
  `type` int(10) UNSIGNED NOT NULL,
  `who` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `what` int(10) UNSIGNED NOT NULL,
  `format` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seen` tinyint(4) NOT NULL DEFAULT 0,
  `datetime` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;
-- ikashop_offlineshop
DROP TABLE IF EXISTS `ikashop_offlineshop`;
CREATE TABLE `ikashop_offlineshop`  (
  `owner` int(10) UNSIGNED NOT NULL,
  `duration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `map` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `x` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `y` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `decoration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `decoration_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `lock_index` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`owner`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;
-- ikashop_private_offer
DROP TABLE IF EXISTS `ikashop_private_offer`;
CREATE TABLE `ikashop_private_offer`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `seller` int(10) UNSIGNED NOT NULL,
  `buyer` int(10) UNSIGNED NOT NULL,
  `item` int(10) UNSIGNED NOT NULL,
  `price` bigint(20) UNSIGNED NOT NULL,
  `notified` tinyint(3) UNSIGNED NOT NULL,
  `accepted` tinyint(3) UNSIGNED NOT NULL,
  `buyer_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datetime` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;
-- ikashop_safebox
DROP TABLE IF EXISTS `ikashop_safebox`;
CREATE TABLE `ikashop_safebox`  (
  `owner` int(10) UNSIGNED NOT NULL,
  `gold` bigint(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`owner`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;
-- ikashop_sale
DROP TABLE IF EXISTS `ikashop_sale`;
CREATE TABLE `ikashop_sale`  (
  `id` int(10) UNSIGNED NOT NULL,
  `vnum` int(10) UNSIGNED NOT NULL,
  `count` int(10) UNSIGNED NOT NULL,
  `price` bigint(20) UNSIGNED NOT NULL,
  `datetime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;
-- item
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `window` enum('INVENTORY','EQUIPMENT','SAFEBOX','MALL','DRAGON_SOUL_INVENTORY','BELT_INVENTORY','GROUND','IKASHOP_OFFLINESHOP','IKASHOP_SAFEBOX','IKASHOP_AUCTION','COSTUME','ACCE','AURA','TALISMAN','PET') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pos` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `count` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `socket0` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `socket1` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `socket2` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `attrtype0` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue0` smallint(6) NOT NULL DEFAULT 0,
  `attrtype1` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue1` smallint(6) NOT NULL DEFAULT 0,
  `attrtype2` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue2` smallint(6) NOT NULL DEFAULT 0,
  `attrtype3` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue3` smallint(6) NOT NULL DEFAULT 0,
  `attrtype4` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue4` smallint(6) NOT NULL DEFAULT 0,
  `attrtype5` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue5` smallint(6) NOT NULL DEFAULT 0,
  `attrtype6` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue6` smallint(6) NOT NULL DEFAULT 0,
  `ikashop_data` tinytext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `profile_lock` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `owner_id_idx`(`owner_id` ASC) USING BTREE,
  INDEX `item_vnum_index`(`vnum` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- item_award
DROP TABLE IF EXISTS `item_award`;
CREATE TABLE `item_award`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'LOGIN_MAX_LEN=30',
  `vnum` int(6) UNSIGNED NOT NULL DEFAULT 0,
  `count` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `given_time` datetime NOT NULL DEFAULT current_timestamp(),
  `taken_time` datetime NULL DEFAULT NULL,
  `item_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `why` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `socket0` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `socket1` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `socket2` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `attrtype0` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue0` smallint(6) NOT NULL DEFAULT 0,
  `attrtype1` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue1` smallint(6) NOT NULL DEFAULT 0,
  `attrtype2` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue2` smallint(6) NOT NULL DEFAULT 0,
  `attrtype3` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue3` smallint(6) NOT NULL DEFAULT 0,
  `attrtype4` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue4` smallint(6) NOT NULL DEFAULT 0,
  `attrtype5` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue5` smallint(6) NOT NULL DEFAULT 0,
  `attrtype6` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue6` smallint(6) NOT NULL DEFAULT 0,
  `mall` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `given_time_idx`(`given_time` ASC) USING BTREE,
  INDEX `taken_time_idx`(`taken_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- land
DROP TABLE IF EXISTS `land`;
CREATE TABLE `land`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `map_index` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `x` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `y` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `width` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `height` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `guild_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `guild_level_limit` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `price` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `enable` enum('YES','NO') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NO',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- lotto_list
DROP TABLE IF EXISTS `lotto_list`;
CREATE TABLE `lotto_list`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `server` varchar(56) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'server%s=get_table_postfix(); std::string so dunno; at least 6',
  `pid` int(10) UNSIGNED NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- marriage
DROP TABLE IF EXISTS `marriage`;
CREATE TABLE `marriage`  (
  `is_married` tinyint(4) NOT NULL DEFAULT 0,
  `pid1` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `pid2` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `love_point` int(11) UNSIGNED NULL DEFAULT NULL,
  `time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`pid1`, `pid2`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- messenger_list
DROP TABLE IF EXISTS `messenger_list`;
CREATE TABLE `messenger_list`  (
  `account` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '24 at maximum',
  `companion` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '24 at maximum',
  PRIMARY KEY (`account`, `companion`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- monarch
DROP TABLE IF EXISTS `monarch`;
CREATE TABLE `monarch`  (
  `empire` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `pid` int(10) UNSIGNED NULL DEFAULT NULL,
  `windate` datetime NULL DEFAULT NULL,
  `money` bigint(20) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`empire`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- monarch_candidacy
DROP TABLE IF EXISTS `monarch_candidacy`;
CREATE TABLE `monarch_candidacy`  (
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `date` datetime NULL DEFAULT current_timestamp(),
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `windate` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`pid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- monarch_election
DROP TABLE IF EXISTS `monarch_election`;
CREATE TABLE `monarch_election`  (
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `selectedpid` int(10) UNSIGNED NULL DEFAULT 0,
  `electiondata` datetime NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`pid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- myshop_pricelist
DROP TABLE IF EXISTS `myshop_pricelist`;
CREATE TABLE `myshop_pricelist`  (
  `owner_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `item_vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `price` int(10) UNSIGNED NOT NULL DEFAULT 0,
  UNIQUE INDEX `list_id`(`owner_id` ASC, `item_vnum` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- object
DROP TABLE IF EXISTS `object`;
CREATE TABLE `object`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `land_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `vnum` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `map_index` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `x` int(11) NOT NULL DEFAULT 0,
  `y` int(11) NOT NULL DEFAULT 0,
  `x_rot` float NOT NULL DEFAULT 0,
  `y_rot` float NOT NULL DEFAULT 0,
  `z_rot` float NOT NULL DEFAULT 0,
  `life` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- object_proto
DROP TABLE IF EXISTS `object_proto`;
CREATE TABLE `object_proto`  (
  `vnum` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `price` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `materials` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `upgrade_vnum` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `upgrade_limit_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `life` int(11) NOT NULL DEFAULT 0,
  `reg_1` int(11) NOT NULL DEFAULT 0,
  `reg_2` int(11) NOT NULL DEFAULT 0,
  `reg_3` int(11) NOT NULL DEFAULT 0,
  `reg_4` int(11) NOT NULL DEFAULT 0,
  `npc` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `group_vnum` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dependent_group` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`vnum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- pcbang_ip
DROP TABLE IF EXISTS `pcbang_ip`;
CREATE TABLE `pcbang_ip`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pcbang_id` int(11) NOT NULL DEFAULT 0,
  `ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '000.000.000.000',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ip`(`ip` ASC) USING BTREE,
  INDEX `pcbang_id`(`pcbang_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- player
DROP TABLE IF EXISTS `player`;
CREATE TABLE `player`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `account_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NONAME',
  `job` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `voice` tinyint(1) NOT NULL DEFAULT 0,
  `dir` tinyint(2) NOT NULL DEFAULT 0,
  `x` int(11) NOT NULL DEFAULT 0,
  `y` int(11) NOT NULL DEFAULT 0,
  `z` int(11) NOT NULL DEFAULT 0,
  `map_index` int(11) NOT NULL DEFAULT 0,
  `exit_x` int(11) NOT NULL DEFAULT 0,
  `exit_y` int(11) NOT NULL DEFAULT 0,
  `exit_map_index` int(11) NOT NULL DEFAULT 0,
  `hp` int(11) NOT NULL DEFAULT 0,
  `mp` int(11) NOT NULL DEFAULT 0,
  `stamina` smallint(6) NOT NULL DEFAULT 0,
  `random_hp` smallint(5) NOT NULL DEFAULT 0 COMMENT 'if lvl 0, it will be negative',
  `random_sp` smallint(5) NOT NULL DEFAULT 0 COMMENT 'if lvl 0, it will be negative',
  `playtime` int(11) NOT NULL DEFAULT 0,
  `level` tinyint(2) UNSIGNED NOT NULL DEFAULT 1,
  `level_step` tinyint(1) NOT NULL DEFAULT 0,
  `st` smallint(3) NOT NULL DEFAULT 0,
  `ht` smallint(3) NOT NULL DEFAULT 0,
  `dx` smallint(3) NOT NULL DEFAULT 0,
  `iq` smallint(3) NOT NULL DEFAULT 0,
  `exp` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `gold` bigint(16) NULL DEFAULT NULL,
  `stat_point` smallint(3) NOT NULL DEFAULT 0,
  `skill_point` smallint(3) NOT NULL DEFAULT 0,
  `quickslot` tinyblob NULL DEFAULT NULL,
  `ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0.0.0.0',
  `part_main` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `part_base` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `part_hair` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `part_acce` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `skill_group` tinyint(4) NOT NULL DEFAULT 0,
  `skill_level` blob NULL DEFAULT NULL,
  `alignment` int(11) NOT NULL DEFAULT 0,
  `last_play` datetime NOT NULL DEFAULT current_timestamp(),
  `change_name` tinyint(1) NOT NULL DEFAULT 0,
  `mobile` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sub_skill_point` smallint(3) NOT NULL DEFAULT 0,
  `stat_reset_count` tinyint(4) NOT NULL DEFAULT 0,
  `horse_hp` smallint(4) NOT NULL DEFAULT 0,
  `horse_stamina` smallint(4) NOT NULL DEFAULT 0,
  `horse_level` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `horse_hp_droptime` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `horse_riding` tinyint(1) NOT NULL DEFAULT 0,
  `horse_skill_point` smallint(3) NOT NULL DEFAULT 0,
  `gaya` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `account_id_idx`(`account_id` ASC) USING BTREE,
  INDEX `name_idx`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- player_deleted
DROP TABLE IF EXISTS `player_deleted`;
CREATE TABLE `player_deleted`  (
  `id` int(11) UNSIGNED NOT NULL,
  `account_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NONAME',
  `job` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `voice` tinyint(1) NOT NULL DEFAULT 0,
  `dir` tinyint(2) NOT NULL DEFAULT 0,
  `x` int(11) NOT NULL DEFAULT 0,
  `y` int(11) NOT NULL DEFAULT 0,
  `z` int(11) NOT NULL DEFAULT 0,
  `map_index` int(11) NOT NULL DEFAULT 0,
  `exit_x` int(11) NOT NULL DEFAULT 0,
  `exit_y` int(11) NOT NULL DEFAULT 0,
  `exit_map_index` int(11) NOT NULL DEFAULT 0,
  `hp` int(11) NOT NULL DEFAULT 0,
  `mp` int(11) NOT NULL DEFAULT 0,
  `stamina` smallint(6) NOT NULL DEFAULT 0,
  `random_hp` smallint(5) NOT NULL DEFAULT 0 COMMENT 'if lvl 0, it will be negative',
  `random_sp` smallint(5) NOT NULL DEFAULT 0 COMMENT 'if lvl 0, it will be negative',
  `playtime` int(11) NOT NULL DEFAULT 0,
  `level` tinyint(2) UNSIGNED NOT NULL DEFAULT 1,
  `level_step` tinyint(1) NOT NULL DEFAULT 0,
  `st` smallint(3) NOT NULL DEFAULT 0,
  `ht` smallint(3) NOT NULL DEFAULT 0,
  `dx` smallint(3) NOT NULL DEFAULT 0,
  `iq` smallint(3) NOT NULL DEFAULT 0,
  `exp` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `gold` bigint(16) NULL DEFAULT NULL,
  `stat_point` smallint(3) NOT NULL DEFAULT 0,
  `skill_point` smallint(3) NOT NULL DEFAULT 0,
  `quickslot` tinyblob NULL DEFAULT NULL,
  `ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0.0.0.0',
  `part_main` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `part_base` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `part_hair` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `part_acce` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `skill_group` tinyint(4) NOT NULL DEFAULT 0,
  `skill_level` blob NULL DEFAULT NULL,
  `alignment` int(11) NOT NULL DEFAULT 0,
  `last_play` datetime NOT NULL DEFAULT current_timestamp(),
  `change_name` tinyint(1) NOT NULL DEFAULT 0,
  `mobile` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sub_skill_point` smallint(3) NOT NULL DEFAULT 0,
  `stat_reset_count` tinyint(4) NOT NULL DEFAULT 0,
  `horse_hp` smallint(4) NOT NULL DEFAULT 0,
  `horse_stamina` smallint(4) NOT NULL DEFAULT 0,
  `horse_level` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `horse_hp_droptime` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `horse_riding` tinyint(1) NOT NULL DEFAULT 0,
  `horse_skill_point` smallint(3) NOT NULL DEFAULT 0,
  `gaya` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- player_index
DROP TABLE IF EXISTS `player_index`;
CREATE TABLE `player_index`  (
  `id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `pid1` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `pid2` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `pid3` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `pid4` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `empire` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid1_key`(`pid1` ASC) USING BTREE,
  INDEX `pid2_key`(`pid2` ASC) USING BTREE,
  INDEX `pid3_key`(`pid3` ASC) USING BTREE,
  INDEX `pid4_key`(`pid4` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- quest
DROP TABLE IF EXISTS `quest`;
CREATE TABLE `quest`  (
  `dwPID` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `szName` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `szState` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `lValue` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`dwPID`, `szName`, `szState`) USING BTREE,
  INDEX `pid_idx`(`dwPID` ASC) USING BTREE,
  INDEX `name_idx`(`szName` ASC) USING BTREE,
  INDEX `state_idx`(`szState` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- safebox
DROP TABLE IF EXISTS `safebox`;
CREATE TABLE `safebox`  (
  `account_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `size` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `password` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `gold` bigint(16) NULL DEFAULT NULL,
  PRIMARY KEY (`account_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- sms_pool
DROP TABLE IF EXISTS `sms_pool`;
CREATE TABLE `sms_pool`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server` int(11) NOT NULL DEFAULT 0,
  `sender` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `receiver` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `mobile` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sent` enum('N','Y') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'N',
  `msg` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sent_idx`(`sent` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- string
DROP TABLE IF EXISTS `string`;
CREATE TABLE `string`  (
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- Panel-yonetimli icerik tablolari (plan 08): db binary bunlari okumaz; panel
-- oyun_okuma ile okur, degisiklikler draft/publish_job -> publish.php ->
-- oyun_yazma uzerinden duser. Kolonlar panel modellerinin kullandigi alanlardir.

-- biolog_info
DROP TABLE IF EXISTS `biolog_info`;
CREATE TABLE `biolog_info`  (
  `mobVnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `level` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `aff_type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `aff_value` smallint(6) NOT NULL DEFAULT 0,
  `aff_type2` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `aff_value2` smallint(6) NOT NULL DEFAULT 0,
  `aff_type3` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `aff_value3` smallint(6) NOT NULL DEFAULT 0,
  `aff_type4` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `aff_value4` smallint(6) NOT NULL DEFAULT 0,
  `item_vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `soul_vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `req_count` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `cool_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `chance` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`mobVnum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- drop_default
DROP TABLE IF EXISTS `drop_default`;
CREATE TABLE `drop_default`  (
  `mob_vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `item_vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `count` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `prob` decimal(5,2) UNSIGNED NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`mob_vnum`, `item_vnum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- drop_mob_group_level
DROP TABLE IF EXISTS `drop_mob_group_level`;
CREATE TABLE `drop_mob_group_level`  (
  `group_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mob_vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `level_start` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `level_end` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`group_id`) USING BTREE,
  INDEX `mob_vnum_idx`(`mob_vnum` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- drop_mob_item_level
DROP TABLE IF EXISTS `drop_mob_item_level`;
CREATE TABLE `drop_mob_item_level`  (
  `group_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `item_vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `count` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `prob` decimal(5,2) UNSIGNED NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`group_id`, `item_vnum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- drop_mob_group_kill
DROP TABLE IF EXISTS `drop_mob_group_kill`;
CREATE TABLE `drop_mob_group_kill`  (
  `group_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mob_vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `kill_per_drop` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`group_id`) USING BTREE,
  INDEX `mob_vnum_idx`(`mob_vnum` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- drop_mob_item_kill
DROP TABLE IF EXISTS `drop_mob_item_kill`;
CREATE TABLE `drop_mob_item_kill`  (
  `group_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `item_vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `count` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `part_prob` decimal(5,2) UNSIGNED NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`group_id`, `item_vnum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- itemshop_category
DROP TABLE IF EXISTS `itemshop_category`;
CREATE TABLE `itemshop_category`  (
  `cat_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `cat_main_id` int(11) UNSIGNED NOT NULL DEFAULT 255,
  PRIMARY KEY (`cat_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- itemshop_item
DROP TABLE IF EXISTS `itemshop_item`;
CREATE TABLE `itemshop_item`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `item_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `price` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `count` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `time_type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `price_type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `socket0` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `socket1` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `socket2` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `socket3` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `attrtype0` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue0` smallint(6) NOT NULL DEFAULT 0,
  `attrtype1` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue1` smallint(6) NOT NULL DEFAULT 0,
  `attrtype2` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue2` smallint(6) NOT NULL DEFAULT 0,
  `attrtype3` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue3` smallint(6) NOT NULL DEFAULT 0,
  `attrtype4` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue4` smallint(6) NOT NULL DEFAULT 0,
  `attrtype5` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue5` smallint(6) NOT NULL DEFAULT 0,
  `attrtype6` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `attrvalue6` smallint(6) NOT NULL DEFAULT 0,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `sell_count` int(11) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_id_idx`(`category_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- fateroulette
DROP TABLE IF EXISTS `fateroulette`;
CREATE TABLE `fateroulette`  (
  `vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `count` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`vnum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- fishevent_items
DROP TABLE IF EXISTS `fishevent_items`;
CREATE TABLE `fishevent_items`  (
  `vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `chance` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`vnum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

CREATE DATABASE IF NOT EXISTS `common` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `common`;

-- exp_table
DROP TABLE IF EXISTS `exp_table`;
CREATE TABLE `exp_table`  (
  `level` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `exp` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`level`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
INSERT INTO `exp_table` VALUES (1, 300);
INSERT INTO `exp_table` VALUES (2, 800);
INSERT INTO `exp_table` VALUES (3, 1500);
INSERT INTO `exp_table` VALUES (4, 2500);
INSERT INTO `exp_table` VALUES (5, 4300);
INSERT INTO `exp_table` VALUES (6, 7200);
INSERT INTO `exp_table` VALUES (7, 11000);
INSERT INTO `exp_table` VALUES (8, 17000);
INSERT INTO `exp_table` VALUES (9, 24000);
INSERT INTO `exp_table` VALUES (10, 33000);
INSERT INTO `exp_table` VALUES (11, 43000);
INSERT INTO `exp_table` VALUES (12, 58000);
INSERT INTO `exp_table` VALUES (13, 76000);
INSERT INTO `exp_table` VALUES (14, 100000);
INSERT INTO `exp_table` VALUES (15, 130000);
INSERT INTO `exp_table` VALUES (16, 169000);
INSERT INTO `exp_table` VALUES (17, 219000);
INSERT INTO `exp_table` VALUES (18, 283000);
INSERT INTO `exp_table` VALUES (19, 365000);
INSERT INTO `exp_table` VALUES (20, 472000);
INSERT INTO `exp_table` VALUES (21, 610000);
INSERT INTO `exp_table` VALUES (22, 705000);
INSERT INTO `exp_table` VALUES (23, 813000);
INSERT INTO `exp_table` VALUES (24, 937000);
INSERT INTO `exp_table` VALUES (25, 1077000);
INSERT INTO `exp_table` VALUES (26, 1237000);
INSERT INTO `exp_table` VALUES (27, 1418000);
INSERT INTO `exp_table` VALUES (28, 1624000);
INSERT INTO `exp_table` VALUES (29, 1857000);
INSERT INTO `exp_table` VALUES (30, 2122000);
INSERT INTO `exp_table` VALUES (31, 2421000);
INSERT INTO `exp_table` VALUES (32, 2761000);
INSERT INTO `exp_table` VALUES (33, 3145000);
INSERT INTO `exp_table` VALUES (34, 3580000);
INSERT INTO `exp_table` VALUES (35, 4073000);
INSERT INTO `exp_table` VALUES (36, 4632000);
INSERT INTO `exp_table` VALUES (37, 5194000);
INSERT INTO `exp_table` VALUES (38, 5717000);
INSERT INTO `exp_table` VALUES (39, 6264000);
INSERT INTO `exp_table` VALUES (40, 6837000);
INSERT INTO `exp_table` VALUES (41, 7600000);
INSERT INTO `exp_table` VALUES (42, 8274000);
INSERT INTO `exp_table` VALUES (43, 8990000);
INSERT INTO `exp_table` VALUES (44, 9753000);
INSERT INTO `exp_table` VALUES (45, 10560000);
INSERT INTO `exp_table` VALUES (46, 11410000);
INSERT INTO `exp_table` VALUES (47, 12320000);
INSERT INTO `exp_table` VALUES (48, 13270000);
INSERT INTO `exp_table` VALUES (49, 14280000);
INSERT INTO `exp_table` VALUES (50, 15340000);
INSERT INTO `exp_table` VALUES (51, 16870000);
INSERT INTO `exp_table` VALUES (52, 18960000);
INSERT INTO `exp_table` VALUES (53, 19980000);
INSERT INTO `exp_table` VALUES (54, 21420000);
INSERT INTO `exp_table` VALUES (55, 22930000);
INSERT INTO `exp_table` VALUES (56, 24530000);
INSERT INTO `exp_table` VALUES (57, 26200000);
INSERT INTO `exp_table` VALUES (58, 27960000);
INSERT INTO `exp_table` VALUES (59, 29800000);
INSERT INTO `exp_table` VALUES (60, 32780000);
INSERT INTO `exp_table` VALUES (61, 36060000);
INSERT INTO `exp_table` VALUES (62, 39670000);
INSERT INTO `exp_table` VALUES (63, 43640000);
INSERT INTO `exp_table` VALUES (64, 48000000);
INSERT INTO `exp_table` VALUES (65, 52800000);
INSERT INTO `exp_table` VALUES (66, 58080000);
INSERT INTO `exp_table` VALUES (67, 63890000);
INSERT INTO `exp_table` VALUES (68, 70280000);
INSERT INTO `exp_table` VALUES (69, 77310000);
INSERT INTO `exp_table` VALUES (70, 85040000);
INSERT INTO `exp_table` VALUES (71, 93540000);
INSERT INTO `exp_table` VALUES (72, 102900000);
INSERT INTO `exp_table` VALUES (73, 113200000);
INSERT INTO `exp_table` VALUES (74, 124500000);
INSERT INTO `exp_table` VALUES (75, 137000000);
INSERT INTO `exp_table` VALUES (76, 150700000);
INSERT INTO `exp_table` VALUES (77, 165700000);
INSERT INTO `exp_table` VALUES (78, 236990000);
INSERT INTO `exp_table` VALUES (79, 260650000);
INSERT INTO `exp_table` VALUES (80, 286780000);
INSERT INTO `exp_table` VALUES (81, 315380000);
INSERT INTO `exp_table` VALUES (82, 346970000);
INSERT INTO `exp_table` VALUES (83, 381680000);
INSERT INTO `exp_table` VALUES (84, 419770000);
INSERT INTO `exp_table` VALUES (85, 461760000);
INSERT INTO `exp_table` VALUES (86, 508040000);
INSERT INTO `exp_table` VALUES (87, 558740000);
INSERT INTO `exp_table` VALUES (88, 614640000);
INSERT INTO `exp_table` VALUES (89, 676130000);
INSERT INTO `exp_table` VALUES (90, 743730000);
INSERT INTO `exp_table` VALUES (91, 1041222000);
INSERT INTO `exp_table` VALUES (92, 1145344200);
INSERT INTO `exp_table` VALUES (93, 1259878620);
INSERT INTO `exp_table` VALUES (94, 1385866482);
INSERT INTO `exp_table` VALUES (95, 1524453130);
INSERT INTO `exp_table` VALUES (96, 1676898443);
INSERT INTO `exp_table` VALUES (97, 1844588288);
INSERT INTO `exp_table` VALUES (98, 2029047116);
INSERT INTO `exp_table` VALUES (99, 2050000000);
INSERT INTO `exp_table` VALUES (100, 2150000000);
INSERT INTO `exp_table` VALUES (101, 2210000000);
INSERT INTO `exp_table` VALUES (102, 2250000000);
INSERT INTO `exp_table` VALUES (103, 2280000000);
INSERT INTO `exp_table` VALUES (104, 2310000000);
INSERT INTO `exp_table` VALUES (105, 2330000000);
INSERT INTO `exp_table` VALUES (106, 2350000000);
INSERT INTO `exp_table` VALUES (107, 2370000000);
INSERT INTO `exp_table` VALUES (108, 2390000000);
INSERT INTO `exp_table` VALUES (109, 2400000000);
INSERT INTO `exp_table` VALUES (110, 2410000000);
INSERT INTO `exp_table` VALUES (111, 2420000000);
INSERT INTO `exp_table` VALUES (112, 2430000000);
INSERT INTO `exp_table` VALUES (113, 2440000000);
INSERT INTO `exp_table` VALUES (114, 2450000000);
INSERT INTO `exp_table` VALUES (115, 2460000000);
INSERT INTO `exp_table` VALUES (116, 2470000000);
INSERT INTO `exp_table` VALUES (117, 2480000000);
INSERT INTO `exp_table` VALUES (118, 2490000000);
INSERT INTO `exp_table` VALUES (119, 2490000000);
INSERT INTO `exp_table` VALUES (120, 2500000000);
-- gmhost
DROP TABLE IF EXISTS `gmhost`;
CREATE TABLE `gmhost`  (
  `mIP` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`mIP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- gmlist
DROP TABLE IF EXISTS `gmlist`;
CREATE TABLE `gmlist`  (
  `mID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mAccount` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `mName` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `mContactIP` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `mServerIP` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ALL',
  `mAuthority` enum('IMPLEMENTOR','HIGH_WIZARD','GOD','LOW_WIZARD','PLAYER') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PLAYER',
  PRIMARY KEY (`mID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- locale
DROP TABLE IF EXISTS `locale`;
CREATE TABLE `locale`  (
  `mKey` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `mValue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`mKey`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
INSERT INTO `locale` VALUES ('DB_NAME_COLUMN', 'locale_name');
INSERT INTO `locale` VALUES ('LOCALE', 'turkey');
INSERT INTO `locale` VALUES ('SKILL_DAMAGE_BY_LEVEL_UNDER_45', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
INSERT INTO `locale` VALUES ('SKILL_DAMAGE_BY_LEVEL_UNDER_90', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
INSERT INTO `locale` VALUES ('SKILL_POWER_BY_LEVEL', '0 5 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 50 52 54 56 58 60 63 66 69 72 82 85 88 91 94 98 102 106 110 115 125 125 125 125 125');
INSERT INTO `locale` VALUES ('SKILL_POWER_BY_LEVEL_TYPE0', '0 5 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 50 52 54 56 58 60 63 66 69 72 82 85 88 91 94 98 102 106 110 115 125 125 125 125 125');
INSERT INTO `locale` VALUES ('SKILL_POWER_BY_LEVEL_TYPE1', '0 5 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 50 52 54 56 58 60 63 66 69 72 82 85 88 91 94 98 102 106 110 115 125 125 125 125 125');
INSERT INTO `locale` VALUES ('SKILL_POWER_BY_LEVEL_TYPE2', '0 5 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 50 52 54 56 58 60 63 66 69 72 82 85 88 91 94 98 102 106 110 115 125 125 125 125 125');
INSERT INTO `locale` VALUES ('SKILL_POWER_BY_LEVEL_TYPE3', '0 5 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 50 52 54 56 58 60 63 66 69 72 82 85 88 91 94 98 102 106 110 115 125 125 125 125 125');
INSERT INTO `locale` VALUES ('SKILL_POWER_BY_LEVEL_TYPE4', '0 5 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 50 52 54 56 58 60 63 66 69 72 82 85 88 91 94 98 102 106 110 115 125 125 125 125 125');
INSERT INTO `locale` VALUES ('SKILL_POWER_BY_LEVEL_TYPE5', '0 5 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 50 52 54 56 58 60 63 66 69 72 82 85 88 91 94 98 102 106 110 115 125 125 125 125 125');
INSERT INTO `locale` VALUES ('SKILL_POWER_BY_LEVEL_TYPE6', '0 5 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 50 52 54 56 58 60 63 66 69 72 82 85 88 91 94 98 102 106 110 115 125 125 125 125 125');
INSERT INTO `locale` VALUES ('SKILL_POWER_BY_LEVEL_TYPE7', '0 5 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 50 52 54 56 58 60 63 66 69 72 82 85 88 91 94 98 102 106 110 115 125 125 125 125 125');
-- priv_settings
DROP TABLE IF EXISTS `priv_settings`;
CREATE TABLE `priv_settings`  (
  `priv_type` enum('PLAYER','GUILD','EMPIRE') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EMPIRE' COMMENT 'GUILD and PLAYER are untested.',
  `id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'this is for empire_id, player_id or guild_id',
  `type` int(10) UNSIGNED NOT NULL DEFAULT 4 COMMENT '1:item_drop, 2:gold_drop, 3:gold10_drop, 4:exp (1~4)',
  `value` int(11) NOT NULL DEFAULT 0 COMMENT '0~1000%',
  `duration` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`priv_type`, `id`, `type`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- spam_db
DROP TABLE IF EXISTS `spam_db`;
CREATE TABLE `spam_db`  (
  `word` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `score` int(3) NOT NULL DEFAULT 1,
  `type` enum('SPAM','MAPS') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'SPAM',
  PRIMARY KEY (`word`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- schema_version
DROP TABLE IF EXISTS `schema_version`;
CREATE TABLE `schema_version` (
  `version` int(10) UNSIGNED NOT NULL,
  `applied_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`version`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
INSERT INTO `schema_version` (`version`) VALUES (1);
-- item_attr
DROP TABLE IF EXISTS `item_attr`;
CREATE TABLE `item_attr`  (
  `apply` enum('MAX_HP','MAX_SP','CON','INT','STR','DEX','ATT_SPEED','MOV_SPEED','CAST_SPEED','HP_REGEN','SP_REGEN','POISON_PCT','STUN_PCT','SLOW_PCT','CRITICAL_PCT','PENETRATE_PCT','ATTBONUS_HUMAN','ATTBONUS_ANIMAL','ATTBONUS_ORC','ATTBONUS_MILGYO','ATTBONUS_UNDEAD','ATTBONUS_DEVIL','STEAL_HP','STEAL_SP','MANA_BURN_PCT','DAMAGE_SP_RECOVER','BLOCK','DODGE','RESIST_SWORD','RESIST_TWOHAND','RESIST_DAGGER','RESIST_BELL','RESIST_FAN','RESIST_BOW','RESIST_FIRE','RESIST_ELEC','RESIST_MAGIC','RESIST_WIND','REFLECT_MELEE','REFLECT_CURSE','POISON_REDUCE','KILL_SP_RECOVER','EXP_DOUBLE_BONUS','GOLD_DOUBLE_BONUS','ITEM_DROP_BONUS','POTION_BONUS','KILL_HP_RECOVER','IMMUNE_STUN','IMMUNE_SLOW','IMMUNE_FALL','SKILL','BOW_DISTANCE','ATT_GRADE_BONUS','DEF_GRADE_BONUS','MAGIC_ATT_GRADE_BONUS','MAGIC_DEF_GRADE_BONUS','CURSE_PCT','MAX_STAMINA','ATT_BONUS_TO_WARRIOR','ATT_BONUS_TO_ASSASSIN','ATT_BONUS_TO_SURA','ATT_BONUS_TO_SHAMAN','ATT_BONUS_TO_MONSTER','ATT_BONUS','MALL_DEFBONUS','MALL_EXPBONUS','MALL_ITEMBONUS','MALL_GOLDBONUS','MAX_HP_PCT','MAX_SP_PCT','SKILL_DAMAGE_BONUS','NORMAL_HIT_DAMAGE_BONUS','SKILL_DEFEND_BONUS','NORMAL_HIT_DEFEND_BONUS','PC_BANG_EXP_BONUS','PC_BANG_DROP_BONUS','EXTRACT_HP_PCT','RESIST_WARRIOR','RESIST_ASSASSIN','RESIST_SURA','RESIST_SHAMAN','ENERGY','DEF_GRADE','COSTUME_ATTR_BONUS','MAGIC_ATT_BONUS_PER','MELEE_MAGIC_ATT_BONUS_PER','RESIST_ICE','RESIST_EARTH','RESIST_DARK','RESIST_CRITICAL','RESIST_PENETRATE','BLEEDING_REDUCE','BLEEDING_PCT','RESERVED_94','RESERVED_95','RESERVED_96','ACCEDRAIN_RATE','RESIST_MAGIC_REDUCTION','ENCHANT_ELECT','ENCHANT_FIRE','ENCHANT_ICE','ENCHANT_WIND','ENCHANT_EARTH','ENCHANT_DARK','ATTBONUS_CZ','ATTBONUS_INSECT','ATTBONUS_DESERT','ATTBONUS_SWORD','ATTBONUS_TWOHAND','ATTBONUS_DAGGER','ATTBONUS_BELL','ATTBONUS_FAN','ATTBONUS_BOW','RESERVED_114','RESIST_HUMAN','RESIST_MOUNT_FALL','UNK_117','MOUNT') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MAX_HP',
  `prob` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `lv1` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `lv2` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `lv3` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `lv4` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `lv5` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `weapon` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `body` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `wrist` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `foots` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `neck` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `head` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `shield` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `ear` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `costume_body` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `costume_hair` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `costume_weapon` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `pendant` int(11) UNSIGNED NOT NULL DEFAULT 0
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- item_attr_rare
DROP TABLE IF EXISTS `item_attr_rare`;
CREATE TABLE `item_attr_rare`  (
  `apply` enum('MAX_HP','MAX_SP','CON','INT','STR','DEX','ATT_SPEED','MOV_SPEED','CAST_SPEED','HP_REGEN','SP_REGEN','POISON_PCT','STUN_PCT','SLOW_PCT','CRITICAL_PCT','PENETRATE_PCT','ATTBONUS_HUMAN','ATTBONUS_ANIMAL','ATTBONUS_ORC','ATTBONUS_MILGYO','ATTBONUS_UNDEAD','ATTBONUS_DEVIL','STEAL_HP','STEAL_SP','MANA_BURN_PCT','DAMAGE_SP_RECOVER','BLOCK','DODGE','RESIST_SWORD','RESIST_TWOHAND','RESIST_DAGGER','RESIST_BELL','RESIST_FAN','RESIST_BOW','RESIST_FIRE','RESIST_ELEC','RESIST_MAGIC','RESIST_WIND','REFLECT_MELEE','REFLECT_CURSE','POISON_REDUCE','KILL_SP_RECOVER','EXP_DOUBLE_BONUS','GOLD_DOUBLE_BONUS','ITEM_DROP_BONUS','POTION_BONUS','KILL_HP_RECOVER','IMMUNE_STUN','IMMUNE_SLOW','IMMUNE_FALL','SKILL','BOW_DISTANCE','ATT_GRADE_BONUS','DEF_GRADE_BONUS','MAGIC_ATT_GRADE_BONUS','MAGIC_DEF_GRADE_BONUS','CURSE_PCT','MAX_STAMINA','ATT_BONUS_TO_WARRIOR','ATT_BONUS_TO_ASSASSIN','ATT_BONUS_TO_SURA','ATT_BONUS_TO_SHAMAN','ATT_BONUS_TO_MONSTER','ATT_BONUS','MALL_DEFBONUS','MALL_EXPBONUS','MALL_ITEMBONUS','MALL_GOLDBONUS','MAX_HP_PCT','MAX_SP_PCT','SKILL_DAMAGE_BONUS','NORMAL_HIT_DAMAGE_BONUS','SKILL_DEFEND_BONUS','NORMAL_HIT_DEFEND_BONUS','PC_BANG_EXP_BONUS','PC_BANG_DROP_BONUS','EXTRACT_HP_PCT','RESIST_WARRIOR','RESIST_ASSASSIN','RESIST_SURA','RESIST_SHAMAN','ENERGY','DEF_GRADE','COSTUME_ATTR_BONUS','MAGIC_ATT_BONUS_PER','MELEE_MAGIC_ATT_BONUS_PER','RESIST_ICE','RESIST_EARTH','RESIST_DARK','RESIST_CRITICAL','RESIST_PENETRATE','BLEEDING_REDUCE','BLEEDING_PCT','RESERVED_94','RESERVED_95','RESERVED_96','ACCEDRAIN_RATE','RESIST_MAGIC_REDUCTION','ENCHANT_ELECT','ENCHANT_FIRE','ENCHANT_ICE','ENCHANT_WIND','ENCHANT_EARTH','ENCHANT_DARK','ATTBONUS_CZ','ATTBONUS_INSECT','ATTBONUS_DESERT','ATTBONUS_SWORD','ATTBONUS_TWOHAND','ATTBONUS_DAGGER','ATTBONUS_BELL','ATTBONUS_FAN','ATTBONUS_BOW','RESERVED_114','RESIST_HUMAN','RESIST_MOUNT_FALL','UNK_117','MOUNT') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MAX_HP',
  `prob` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `lv1` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `lv2` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `lv3` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `lv4` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `lv5` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `weapon` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `body` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `wrist` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `foots` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `neck` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `head` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `shield` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `ear` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `costume_body` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `costume_hair` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `costume_weapon` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `pendant` int(11) UNSIGNED NOT NULL DEFAULT 0
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- item_proto
DROP TABLE IF EXISTS `item_proto`;
CREATE TABLE `item_proto`  (
  `vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `name` varbinary(24) NOT NULL DEFAULT 'Noname',
  `locale_name` varbinary(24) NOT NULL DEFAULT 'Noname',
  `type` tinyint(2) NOT NULL DEFAULT 0,
  `subtype` tinyint(2) NOT NULL DEFAULT 0,
  `weight` tinyint(3) NULL DEFAULT 0,
  `size` tinyint(3) UNSIGNED NULL DEFAULT 0,
  `antiflag` int(11) UNSIGNED NULL DEFAULT 0,
  `flag` int(11) UNSIGNED NULL DEFAULT 0,
  `wearflag` int(11) UNSIGNED NULL DEFAULT 0,
  `immuneflag` set('PARA','CURSE','STUN','SLEEP','SLOW','POISON','TERROR') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `gold` bigint(16) NULL DEFAULT NULL,
  `shop_buy_price` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `refined_vnum` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `refine_set` smallint(11) UNSIGNED NOT NULL DEFAULT 0,
  `refine_set2` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `magic_pct` tinyint(4) NOT NULL DEFAULT 0,
  `limittype0` tinyint(4) UNSIGNED NULL DEFAULT 0,
  `limitvalue0` int(11) NULL DEFAULT 0,
  `limittype1` tinyint(4) UNSIGNED NULL DEFAULT 0,
  `limitvalue1` int(11) NULL DEFAULT 0,
  `applytype0` tinyint(4) UNSIGNED NULL DEFAULT 0,
  `applyvalue0` int(11) NULL DEFAULT 0,
  `applytype1` tinyint(4) UNSIGNED NULL DEFAULT 0,
  `applyvalue1` int(11) NULL DEFAULT 0,
  `applytype2` tinyint(4) UNSIGNED NULL DEFAULT 0,
  `applyvalue2` int(11) NULL DEFAULT 0,
  `value0` int(11) NULL DEFAULT 0,
  `value1` int(11) NULL DEFAULT 0,
  `value2` int(11) NULL DEFAULT 0,
  `value3` int(11) NULL DEFAULT 0,
  `value4` int(11) NULL DEFAULT 0,
  `value5` int(11) NULL DEFAULT 0,
  `socket0` tinyint(4) NULL DEFAULT -1,
  `socket1` tinyint(4) NULL DEFAULT -1,
  `socket2` tinyint(4) NULL DEFAULT -1,
  `socket3` tinyint(4) NULL DEFAULT -1,
  `socket4` tinyint(4) NULL DEFAULT -1,
  `socket5` tinyint(4) NULL DEFAULT -1,
  `specular` tinyint(4) NOT NULL DEFAULT 0,
  `socket_pct` tinyint(4) NOT NULL DEFAULT 0,
  `addon_type` smallint(6) NOT NULL DEFAULT 0,
  `min_profile` smallint(5) UNSIGNED NOT NULL DEFAULT 99,
  PRIMARY KEY (`vnum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- mob_proto
DROP TABLE IF EXISTS `mob_proto`;
CREATE TABLE `mob_proto`  (
  `vnum` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Noname',
  `locale_name` varbinary(24) NOT NULL DEFAULT 'Noname',
  `rank` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `type` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `battle_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `level` smallint(3) UNSIGNED NOT NULL DEFAULT 1,
  `size` enum('SMALL','MEDIUM','BIG') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'SMALL',
  `ai_flag` set('AGGR','NOMOVE','COWARD','NOATTSHINSU','NOATTCHUNJO','NOATTJINNO','ATTMOB','BERSERK','STONESKIN','GODSPEED','DEATHBLOW','REVIVE') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `mount_capacity` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `setRaceFlag` set('ANIMAL','UNDEAD','DEVIL','HUMAN','ORC','MILGYO','INSECT','FIRE','ICE','DESERT','TREE','ATT_ELEC','ATT_FIRE','ATT_ICE','ATT_WIND','ATT_EARTH','ATT_DARK') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `setImmuneFlag` set('STUN','SLOW','FALL','CURSE','POISON','TERROR','REFLECT') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `empire` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `folder` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `on_click` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `st` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `dx` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `ht` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `iq` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `damage_min` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `damage_max` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `max_hp` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `regen_cycle` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `regen_percent` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `gold_min` bigint(16) NULL DEFAULT NULL,
  `gold_max` bigint(16) NULL DEFAULT NULL,
  `exp` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `def` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `attack_speed` smallint(6) UNSIGNED NOT NULL DEFAULT 100,
  `move_speed` smallint(6) UNSIGNED NOT NULL DEFAULT 100,
  `aggressive_hp_pct` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `aggressive_sight` smallint(10) UNSIGNED NOT NULL DEFAULT 0,
  `attack_range` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `drop_item` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `resurrection_vnum` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `enchant_curse` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `enchant_slow` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `enchant_poison` tinyint(4) UNSIGNED NOT NULL DEFAULT 0,
  `enchant_stun` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `enchant_critical` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `enchant_penetrate` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `resist_sword` tinyint(4) NOT NULL DEFAULT 0,
  `resist_twohand` tinyint(4) NOT NULL DEFAULT 0,
  `resist_dagger` tinyint(4) NOT NULL DEFAULT 0,
  `resist_bell` tinyint(4) NOT NULL DEFAULT 0,
  `resist_fan` tinyint(4) NOT NULL DEFAULT 0,
  `resist_bow` tinyint(4) NOT NULL DEFAULT 0,
  `resist_fire` tinyint(4) NOT NULL DEFAULT 0,
  `resist_elect` tinyint(4) NOT NULL DEFAULT 0,
  `resist_magic` tinyint(4) NOT NULL DEFAULT 0,
  `resist_wind` tinyint(4) NOT NULL DEFAULT 0,
  `resist_poison` tinyint(4) NOT NULL DEFAULT 0,
  `dam_multiply` float NULL DEFAULT NULL,
  `summon` int(11) NULL DEFAULT NULL,
  `drain_sp` int(11) NULL DEFAULT NULL,
  `mob_color` int(10) UNSIGNED NULL DEFAULT NULL,
  `polymorph_item` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skill_level0` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `skill_vnum0` int(10) UNSIGNED NULL DEFAULT NULL,
  `skill_level1` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `skill_vnum1` int(10) UNSIGNED NULL DEFAULT NULL,
  `skill_level2` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `skill_vnum2` int(10) UNSIGNED NULL DEFAULT NULL,
  `skill_level3` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `skill_vnum3` int(10) UNSIGNED NULL DEFAULT NULL,
  `skill_level4` tinyint(3) UNSIGNED NULL DEFAULT NULL,
  `skill_vnum4` int(10) UNSIGNED NULL DEFAULT NULL,
  `sp_berserk` tinyint(4) NOT NULL DEFAULT 0,
  `sp_stoneskin` tinyint(4) NOT NULL DEFAULT 0,
  `sp_godspeed` tinyint(4) NOT NULL DEFAULT 0,
  `sp_deathblow` tinyint(4) NOT NULL DEFAULT 0,
  `sp_revive` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`vnum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- refine_proto
DROP TABLE IF EXISTS `refine_proto`;
CREATE TABLE `refine_proto`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vnum0` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `count0` smallint(6) NOT NULL DEFAULT 0,
  `vnum1` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `count1` smallint(6) NOT NULL DEFAULT 0,
  `vnum2` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `count2` smallint(6) NOT NULL DEFAULT 0,
  `vnum3` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `count3` smallint(6) NOT NULL DEFAULT 0,
  `vnum4` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `count4` smallint(6) NOT NULL DEFAULT 0,
  `cost` bigint(11) NOT NULL DEFAULT 0,
  `src_vnum` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `result_vnum` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `prob` smallint(6) NOT NULL DEFAULT 100,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- shop
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop`  (
  `vnum` int(11) NOT NULL DEFAULT 0,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Noname',
  `npc_vnum` smallint(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`vnum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- shop_item
DROP TABLE IF EXISTS `shop_item`;
CREATE TABLE `shop_item`  (
  `shop_vnum` int(11) NOT NULL DEFAULT 0,
  `item_vnum` int(11) NOT NULL DEFAULT 0,
  `count` tinyint(4) UNSIGNED NOT NULL DEFAULT 1,
  UNIQUE INDEX `vnum_unique`(`shop_vnum` ASC, `item_vnum` ASC, `count` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- skill_proto
DROP TABLE IF EXISTS `skill_proto`;
CREATE TABLE `skill_proto`  (
  `dwVnum` int(11) NOT NULL DEFAULT 0,
  `szName` varbinary(32) NOT NULL DEFAULT '',
  `bType` tinyint(4) NOT NULL DEFAULT 0,
  `bLevelStep` tinyint(4) NOT NULL DEFAULT 0,
  `bMaxLevel` tinyint(4) NOT NULL DEFAULT 0,
  `bLevelLimit` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `szPointOn` enum('NONE','MAX_HP','MAX_SP','HP_REGEN','SP_REGEN','BLOCK','HP','SP','ATT_GRADE','DEF_GRADE','MAGIC_ATT_GRADE','MAGIC_DEF_GRADE','BOW_DISTANCE','MOV_SPEED','ATT_SPEED','POISON_PCT','RESIST_RANGE','RESIST_MELEE','CASTING_SPEED','REFLECT_MELEE','ATT_BONUS','DEF_BONUS','RESIST_NORMAL','DODGE','KILL_HP_RECOVER','KILL_SP_RECOVER','HIT_HP_RECOVER','HIT_SP_RECOVER','CRITICAL','MANASHIELD','SKILL_DAMAGE_BONUS','NORMAL_HIT_DAMAGE_BONUS') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NONE',
  `szPointPoly` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `szSPCostPoly` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `szDurationPoly` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `szDurationSPCostPoly` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `szCooldownPoly` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `szMasterBonusPoly` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `szAttackGradePoly` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `setFlag` set('ATTACK','USE_MELEE_DAMAGE','COMPUTE_ATTGRADE','SELFONLY','USE_MAGIC_DAMAGE','USE_HP_AS_COST','COMPUTE_MAGIC_DAMAGE','SPLASH','GIVE_PENALTY','USE_ARROW_DAMAGE','PENETRATE','IGNORE_TARGET_RATING','ATTACK_SLOW','ATTACK_STUN','HP_ABSORB','SP_ABSORB','ATTACK_FIRE_CONT','REMOVE_BAD_AFFECT','REMOVE_GOOD_AFFECT','CRUSH','ATTACK_POISON','TOGGLE','DISABLE_BY_POINT_UP','CRUSH_LONG','ATTACK_WIND','ATTACK_ELEC','ATTACK_FIRE','ATTACK_BLEEDING','PARTY') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `setAffectFlag` enum('YMIR','INVISIBILITY','SPAWN','POISON','SLOW','STUN','DUNGEON_READY','DUNGEON_UNIQUE','BUILDING_CONSTRUCTION_SMALL','BUILDING_CONSTRUCTION_LARGE','BUILDING_UPGRADE','MOV_SPEED_POTION','ATT_SPEED_POTION','FISH_MIND','JEONGWIHON','GEOMGYEONG','CHEONGEUN','GYEONGGONG','EUNHYUNG','GWIGUM','TERROR','JUMAGAP','HOSIN','BOHO','KWAESOK','MANASHIELD','MUYEONG','REVIVE_INVISIBLE','FIRE','GICHEON','JEUNGRYEOK','TANHWAN_DASH','PABEOP','CHEONGEUN_WITH_FALL','POLYMORPH','WAR_FLAG1','WAR_FLAG2','WAR_FLAG3','CHINA_FIREWORK','HAIR','GERMANY','RAMADAN_RING','BLEEDING','RED_POSSESSION','BLUE_POSSESSION') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'YMIR',
  `szPointOn2` enum('NONE','MAX_HP','MAX_SP','HP_REGEN','SP_REGEN','BLOCK','HP','SP','ATT_GRADE','DEF_GRADE','MAGIC_ATT_GRADE','MAGIC_DEF_GRADE','BOW_DISTANCE','MOV_SPEED','ATT_SPEED','POISON_PCT','RESIST_RANGE','RESIST_MELEE','CASTING_SPEED','REFLECT_MELEE','ATT_BONUS','DEF_BONUS','RESIST_NORMAL','DODGE','KILL_HP_RECOVER','KILL_SP_RECOVER','HIT_HP_RECOVER','HIT_SP_RECOVER','CRITICAL','MANASHIELD','SKILL_DAMAGE_BONUS','NORMAL_HIT_DAMAGE_BONUS') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NONE',
  `szPointPoly2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `szDurationPoly2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `setAffectFlag2` enum('YMIR','INVISIBILITY','SPAWN','POISON','SLOW','STUN','DUNGEON_READY','DUNGEON_UNIQUE','BUILDING_CONSTRUCTION_SMALL','BUILDING_CONSTRUCTION_LARGE','BUILDING_UPGRADE','MOV_SPEED_POTION','ATT_SPEED_POTION','FISH_MIND','JEONGWIHON','GEOMGYEONG','CHEONGEUN','GYEONGGONG','EUNHYUNG','GWIGUM','TERROR','JUMAGAP','HOSIN','BOHO','KWAESOK','MANASHIELD','MUYEONG','REVIVE_INVISIBLE','FIRE','GICHEON','JEUNGRYEOK','TANHWAN_DASH','PABEOP','CHEONGEUN_WITH_FALL','POLYMORPH','WAR_FLAG1','WAR_FLAG2','WAR_FLAG3','CHINA_FIREWORK','HAIR','GERMANY','RAMADAN_RING','BLEEDING','RED_POSSESSION','BLUE_POSSESSION') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'YMIR',
  `szPointOn3` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NONE',
  `szPointPoly3` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `szDurationPoly3` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `szGrandMasterAddSPCostPoly` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `prerequisiteSkillVnum` int(11) NOT NULL DEFAULT 0,
  `prerequisiteSkillLevel` int(11) NOT NULL DEFAULT 0,
  `eSkillType` enum('NORMAL','MELEE','RANGE','MAGIC') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NORMAL',
  `iMaxHit` tinyint(4) NOT NULL DEFAULT 0,
  `szSplashAroundDamageAdjustPoly` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `dwTargetRange` int(11) NOT NULL DEFAULT 1000,
  `dwSplashRange` int(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`dwVnum`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

CREATE DATABASE IF NOT EXISTS `log` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `log`;

-- GameTimeLog
DROP TABLE IF EXISTS `GameTimeLog`;
CREATE TABLE `GameTimeLog`  (
  `login` varbinary(16) NULL DEFAULT NULL,
  `type` int(11) UNSIGNED NULL DEFAULT NULL,
  `logon_time` datetime NULL DEFAULT NULL,
  `logout_time` datetime NULL DEFAULT NULL,
  `use_time` int(15) UNSIGNED NULL DEFAULT NULL,
  `ip` varbinary(15) NULL DEFAULT NULL,
  `server` varbinary(56) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- acce
DROP TABLE IF EXISTS `acce`;
CREATE TABLE `acce`  (
  `pid` int(11) NOT NULL,
  `time` timestamp NOT NULL,
  `x` int(1) NOT NULL,
  `y` int(1) NOT NULL,
  `item_vnum` int(11) NOT NULL,
  `item_uid` int(11) NOT NULL,
  `item_count` smallint(3) NOT NULL,
  `item_abs_chance` smallint(3) NOT NULL,
  `success` varbinary(3) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- bootlog
DROP TABLE IF EXISTS `bootlog`;
CREATE TABLE `bootlog`  (
  `time` datetime NULL DEFAULT NULL,
  `hostname` varbinary(56) NULL DEFAULT NULL,
  `channel` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- change_empire
DROP TABLE IF EXISTS `change_empire`;
CREATE TABLE `change_empire`  (
  `account_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `change_count` int(11) NULL DEFAULT NULL,
  `data` datetime NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- change_name
DROP TABLE IF EXISTS `change_name`;
CREATE TABLE `change_name`  (
  `pid` int(11) UNSIGNED NULL DEFAULT NULL,
  `old_name` varbinary(16) NULL DEFAULT NULL,
  `new_name` varbinary(16) NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  `ip` varbinary(15) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- chat_log
DROP TABLE IF EXISTS `chat_log`;
CREATE TABLE `chat_log`  (
  `where` int(10) UNSIGNED NOT NULL,
  `who_id` int(10) UNSIGNED NOT NULL,
  `who_name` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `whom_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `whom_name` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `type` enum('NORMAL','WHISPER','PARTY','GUILD') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `msg` varbinary(512) NOT NULL,
  `when` datetime NOT NULL DEFAULT current_timestamp(),
  `ip` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- command_log
DROP TABLE IF EXISTS `command_log`;
CREATE TABLE `command_log`  (
  `userid` int(11) UNSIGNED NULL DEFAULT NULL,
  `server` int(11) NULL DEFAULT 999,
  `ip` varbinary(15) NULL DEFAULT NULL,
  `port` int(11) UNSIGNED NULL DEFAULT NULL,
  `username` varbinary(16) NULL DEFAULT NULL,
  `command` varbinary(300) NULL DEFAULT NULL,
  `date` datetime NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- cube
DROP TABLE IF EXISTS `cube`;
CREATE TABLE `cube`  (
  `pid` int(11) UNSIGNED NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  `x` int(11) UNSIGNED NULL DEFAULT NULL,
  `y` int(11) UNSIGNED NULL DEFAULT NULL,
  `item_vnum` int(11) UNSIGNED NULL DEFAULT NULL,
  `item_uid` int(11) UNSIGNED NULL DEFAULT NULL,
  `item_count` int(11) NULL DEFAULT NULL,
  `success` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- dragon_slay_log
DROP TABLE IF EXISTS `dragon_slay_log`;
CREATE TABLE `dragon_slay_log`  (
  `guild_id` int(11) UNSIGNED NOT NULL,
  `vnum` int(11) UNSIGNED NOT NULL,
  `start_time` datetime NOT NULL DEFAULT current_timestamp(),
  `end_time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- fish_log
DROP TABLE IF EXISTS `fish_log`;
CREATE TABLE `fish_log`  (
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `player_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `map_index` tinyint(4) NOT NULL DEFAULT 0,
  `fish_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fishing_level` int(11) NOT NULL DEFAULT 0,
  `waiting_time` int(11) NOT NULL DEFAULT 0,
  `success` tinyint(4) NOT NULL DEFAULT 0,
  `size` smallint(6) NOT NULL DEFAULT 0
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- goldlog
DROP TABLE IF EXISTS `goldlog`;
CREATE TABLE `goldlog`  (
  `date` date NULL DEFAULT NULL,
  `time` time NULL DEFAULT NULL,
  `pid` int(11) UNSIGNED NULL DEFAULT NULL,
  `what` int(11) UNSIGNED NULL DEFAULT NULL,
  `how` varbinary(33) NULL DEFAULT NULL COMMENT 'contains: QUEST, BUY, SELL, SHOP_BUY, SHOP_SELL, EXCHANGE_TAKE, EXCHANGE_GIVE',
  `hint` varbinary(80) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- hack_crc_log
DROP TABLE IF EXISTS `hack_crc_log`;
CREATE TABLE `hack_crc_log`  (
  `time` datetime NULL DEFAULT NULL,
  `login` varbinary(16) NULL DEFAULT NULL,
  `name` varbinary(16) NULL DEFAULT NULL,
  `ip` varbinary(15) NULL DEFAULT NULL,
  `server` varbinary(56) NULL DEFAULT NULL,
  `why` varbinary(33) NULL DEFAULT NULL,
  `crc` int(11) UNSIGNED NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- hack_log
DROP TABLE IF EXISTS `hack_log`;
CREATE TABLE `hack_log`  (
  `time` datetime NULL DEFAULT NULL,
  `login` varbinary(16) NULL DEFAULT NULL,
  `name` varbinary(16) NULL DEFAULT NULL,
  `ip` varbinary(15) NULL DEFAULT NULL,
  `server` varbinary(56) NULL DEFAULT NULL,
  `why` varbinary(33) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- hackshield_log
DROP TABLE IF EXISTS `hackshield_log`;
CREATE TABLE `hackshield_log`  (
  `time` datetime NULL DEFAULT NULL,
  `account_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `login` varbinary(16) NULL DEFAULT NULL,
  `pid` int(11) UNSIGNED NULL DEFAULT NULL,
  `name` varbinary(16) NULL DEFAULT NULL,
  `reason` int(11) UNSIGNED NULL DEFAULT NULL,
  `ip` int(11) UNSIGNED NULL DEFAULT NULL COMMENT 'inet_aton(\'%s\')'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- invalid_server_log
DROP TABLE IF EXISTS `invalid_server_log`;
CREATE TABLE `invalid_server_log`  (
  `locale_type` int(11) UNSIGNED NULL DEFAULT NULL,
  `log_date` datetime NULL DEFAULT NULL,
  `ip` varbinary(15) NULL DEFAULT NULL,
  `revision` varbinary(16) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- levellog
DROP TABLE IF EXISTS `levellog`;
CREATE TABLE `levellog`  (
  `name` varbinary(16) NULL DEFAULT NULL,
  `level` int(11) UNSIGNED NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  `account_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `pid` int(11) UNSIGNED NULL DEFAULT NULL COMMENT 'contains REPLACE query!',
  `playtime` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- log
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log`  (
  `type` varbinary(20) NULL DEFAULT NULL COMMENT 'contains: CHARACTER, ITEM',
  `time` datetime NULL DEFAULT NULL,
  `who` int(11) UNSIGNED NULL DEFAULT NULL,
  `x` int(11) UNSIGNED NULL DEFAULT NULL,
  `y` int(11) UNSIGNED NULL DEFAULT NULL,
  `what` bigint(11) UNSIGNED NULL DEFAULT NULL,
  `how` varbinary(50) NULL DEFAULT NULL,
  `hint` varbinary(80) NULL DEFAULT NULL COMMENT 'snprintf with 80u size',
  `ip` varbinary(15) NULL DEFAULT NULL,
  `vnum` int(11) UNSIGNED NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- loginlog
DROP TABLE IF EXISTS `loginlog`;
CREATE TABLE `loginlog`  (
  `type` varbinary(20) NULL DEFAULT NULL COMMENT 'contains: LOGIN, LOGOUT',
  `time` datetime NULL DEFAULT NULL,
  `channel` int(11) NULL DEFAULT NULL,
  `account_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `pid` int(11) UNSIGNED NULL DEFAULT NULL,
  `level` int(11) NULL DEFAULT NULL,
  `job` int(11) NULL DEFAULT NULL,
  `playtime` int(11) UNSIGNED NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- loginlog2
DROP TABLE IF EXISTS `loginlog2`;
CREATE TABLE `loginlog2`  (
  `type` varbinary(20) NULL DEFAULT NULL COMMENT 'contains: VALID, INVALID',
  `is_gm` varbinary(20) NULL DEFAULT NULL COMMENT 'contains: Y, N',
  `login_time` datetime NULL DEFAULT NULL,
  `channel` int(11) NULL DEFAULT NULL,
  `account_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `pid` int(11) UNSIGNED NULL DEFAULT NULL,
  `ip` int(11) UNSIGNED NULL DEFAULT NULL COMMENT 'inet_aton(\'%s\')',
  `client_version` varbinary(11) NULL DEFAULT NULL COMMENT 'maybe 1215955205',
  `logout_time` datetime NULL DEFAULT NULL,
  `playtime` datetime NULL DEFAULT NULL,
  `id` int(11) NULL DEFAULT NULL COMMENT 'maybe primary'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- money_log
DROP TABLE IF EXISTS `money_log`;
CREATE TABLE `money_log`  (
  `time` datetime NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL,
  `vnum` int(11) NULL DEFAULT NULL,
  `gold` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- pcbang_loginlog
DROP TABLE IF EXISTS `pcbang_loginlog`;
CREATE TABLE `pcbang_loginlog`  (
  `time` datetime NULL DEFAULT NULL,
  `pcbang_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `ip` varbinary(15) NULL DEFAULT NULL,
  `pid` int(11) UNSIGNED NULL DEFAULT NULL,
  `play_time` int(11) UNSIGNED NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- quest_reward_log
DROP TABLE IF EXISTS `quest_reward_log`;
CREATE TABLE `quest_reward_log`  (
  `quest_name` varbinary(56) NULL DEFAULT NULL,
  `pid` int(11) UNSIGNED NULL DEFAULT NULL,
  `level` int(11) UNSIGNED NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL COMMENT 'contains: EXP, ITEM',
  `how` int(11) UNSIGNED NULL DEFAULT NULL,
  `hint` int(11) UNSIGNED NULL DEFAULT NULL,
  `when` datetime NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- refinelog
DROP TABLE IF EXISTS `refinelog`;
CREATE TABLE `refinelog`  (
  `pid` int(11) UNSIGNED NULL DEFAULT NULL,
  `item_name` varbinary(56) NULL DEFAULT NULL,
  `item_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `step` int(11) NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  `is_success` tinyint(1) NULL DEFAULT NULL,
  `setType` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'contains: HYUNIRON, POWER, SCROLL'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- shout_log
DROP TABLE IF EXISTS `shout_log`;
CREATE TABLE `shout_log`  (
  `when` datetime NULL DEFAULT NULL,
  `where` int(11) NULL DEFAULT NULL,
  `empire` int(11) NULL DEFAULT NULL,
  `message` varbinary(512) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- speed_hack
DROP TABLE IF EXISTS `speed_hack`;
CREATE TABLE `speed_hack`  (
  `pid` int(11) UNSIGNED NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  `x` int(11) NULL DEFAULT NULL,
  `y` int(11) NULL DEFAULT NULL,
  `hack_count` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- vcard_log
DROP TABLE IF EXISTS `vcard_log`;
CREATE TABLE `vcard_log`  (
  `vcard_id` int(11) UNSIGNED NULL DEFAULT NULL,
  `x` int(11) UNSIGNED NULL DEFAULT NULL,
  `y` int(11) UNSIGNED NULL DEFAULT NULL,
  `hostname` varbinary(56) NULL DEFAULT NULL,
  `giver_name` varbinary(16) NULL DEFAULT NULL,
  `giver_ip` varbinary(15) NULL DEFAULT NULL,
  `taker_name` varbinary(16) NULL DEFAULT NULL,
  `taker_ip` varbinary(15) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;
-- ikarusshop_log: db binary writes here when ENABLE_IKASHOP_LOGS is on (SQL_LOG).
-- cheque column intentionally absent (no won/cheque).
DROP TABLE IF EXISTS `ikarusshop_log`;
CREATE TABLE `ikarusshop_log`  (
  `who` int(11) UNSIGNED NULL DEFAULT NULL,
  `itemid` int(11) UNSIGNED NULL DEFAULT NULL,
  `what` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `shop_owner` int(11) UNSIGNED NULL DEFAULT NULL,
  `extra` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `vnum` int(11) UNSIGNED NULL DEFAULT NULL,
  `count` int(11) UNSIGNED NULL DEFAULT NULL,
  `yang` bigint(20) NULL DEFAULT NULL,
  `when` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- Binary compatibility: Srcs/Server/db runs proto/shop/skill/item_attr queries on the
-- SQL_PLAYER connection (DirectQuery default slot) and mirrors item_proto/mob_proto
-- into the player database (conf.txt PROTO_FROM_DB=0, MIRROR2DB=1).
-- The `common` copies above stay canonical for the plan/panel; these LIKE copies let
-- the db binary boot and mirror without touching `common`.
DROP TABLE IF EXISTS `player`.`item_proto`;
CREATE TABLE `player`.`item_proto` LIKE `common`.`item_proto`;
DROP TABLE IF EXISTS `player`.`mob_proto`;
CREATE TABLE `player`.`mob_proto` LIKE `common`.`mob_proto`;
DROP TABLE IF EXISTS `player`.`shop`;
CREATE TABLE `player`.`shop` LIKE `common`.`shop`;
DROP TABLE IF EXISTS `player`.`shop_item`;
CREATE TABLE `player`.`shop_item` LIKE `common`.`shop_item`;
DROP TABLE IF EXISTS `player`.`refine_proto`;
CREATE TABLE `player`.`refine_proto` LIKE `common`.`refine_proto`;
DROP TABLE IF EXISTS `player`.`item_attr`;
CREATE TABLE `player`.`item_attr` LIKE `common`.`item_attr`;
DROP TABLE IF EXISTS `player`.`item_attr_rare`;
CREATE TABLE `player`.`item_attr_rare` LIKE `common`.`item_attr_rare`;
DROP TABLE IF EXISTS `player`.`skill_proto`;
CREATE TABLE `player`.`skill_proto` LIKE `common`.`skill_proto`;

-- hotbackup: conf.txt SQL_HOTBACKUP points here. The db binary creates its own
-- hb_YYMMDDHH_player tables at runtime (HB.cpp: CREATE TABLE IF NOT EXISTS from
-- SHOW CREATE TABLE player), so the database only needs to exist.
CREATE DATABASE IF NOT EXISTS `hotbackup` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
