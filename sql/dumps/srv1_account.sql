/*
 Navicat Premium Dump SQL

 Source Server         : 5.10.220.69_marty
 Source Server Type    : MariaDB
 Source Server Version : 101114 (10.11.14-MariaDB)
 Source Host           : 5.10.220.69:3306
 Source Schema         : srv1_account

 Target Server Type    : MariaDB
 Target Server Version : 101114 (10.11.14-MariaDB)
 File Encoding         : 65001

 Date: 11/12/2025 22:15:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for GameTime
-- ----------------------------
DROP TABLE IF EXISTS `GameTime`;
CREATE TABLE `GameTime`  (
  `UserID` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `paymenttype` tinyint(2) NOT NULL DEFAULT 1,
  `LimitTime` int(11) UNSIGNED NULL DEFAULT 0,
  `LimitDt` datetime NULL DEFAULT current_timestamp(),
  `Scores` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`UserID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of GameTime
-- ----------------------------

-- ----------------------------
-- Table structure for GameTimeIP
-- ----------------------------
DROP TABLE IF EXISTS `GameTimeIP`;
CREATE TABLE `GameTimeIP`  (
  `ipid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ip` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '000.000.000.000',
  `startIP` int(11) NOT NULL DEFAULT 0,
  `endIP` int(11) NOT NULL DEFAULT 255,
  `paymenttype` tinyint(2) NOT NULL DEFAULT 1,
  `LimitTime` int(11) NOT NULL DEFAULT 0,
  `LimitDt` datetime NOT NULL DEFAULT current_timestamp(),
  `readme` varchar(128) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ipid`) USING BTREE,
  UNIQUE INDEX `ip_uniq`(`ip` ASC, `startIP` ASC, `endIP` ASC) USING BTREE,
  INDEX `ip_idx`(`ip` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of GameTimeIP
-- ----------------------------

-- ----------------------------
-- Table structure for GameTimeLog
-- ----------------------------
DROP TABLE IF EXISTS `GameTimeLog`;
CREATE TABLE `GameTimeLog`  (
  `login` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `type` enum('IP_FREE','FREE','IP_TIME','IP_DAY','TIME','DAY') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `logon_time` datetime NOT NULL DEFAULT current_timestamp(),
  `logout_time` datetime NOT NULL DEFAULT current_timestamp(),
  `use_time` int(11) UNSIGNED NULL DEFAULT NULL,
  `ip` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '000.000.000.000',
  `server` varchar(56) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  INDEX `login_key`(`login` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of GameTimeLog
-- ----------------------------

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'LOGIN_MAX_LEN=30',
  `password` varchar(42) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '' COMMENT 'PASSWD_MAX_LEN=16; default 45 size',
  `social_id` varchar(7) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `email` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `securitycode` varchar(192) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `status` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'OK',
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
  `real_name` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  `question1` varchar(56) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `answer1` varchar(56) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `question2` varchar(56) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `answer2` varchar(56) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cash` int(11) NULL DEFAULT 0,
  `mileage` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `login`(`login` ASC) USING BTREE,
  INDEX `social_id`(`social_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES (1, 'root', '*00A51F3F48415C7D4E8908980D443C29C69B60C9', '', '', '', 'OK', '2024-10-27 01:13:29', '2024-10-27 01:13:29', '2024-11-09 12:45:37', '2024-10-27 01:13:29', '2024-10-27 01:13:29', '2024-10-27 01:13:29', '2024-10-27 01:13:29', '2024-10-27 01:13:29', '2024-10-27 01:13:29', '2024-10-27 01:13:29', '', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO `account` VALUES (2, 'asd', '*00A51F3F48415C7D4E8908980D443C29C69B60C9', '', '', '', 'OK', '2024-10-31 20:26:06', '2024-10-31 20:26:06', '2024-11-09 05:01:19', '2024-10-31 20:26:06', '2024-10-31 20:26:06', '2024-10-31 20:26:06', '2024-10-31 20:26:06', '2024-10-31 20:26:06', '2024-10-31 20:26:06', '2024-10-31 20:26:06', '', NULL, NULL, NULL, NULL, 0, 0);
INSERT INTO `account` VALUES (3, 'asd1', '*00A51F3F48415C7D4E8908980D443C29C69B60C9', '', '', '', 'OK', '2024-11-03 16:09:47', '2024-11-03 16:09:47', '2024-11-03 16:12:01', '2024-11-03 16:09:47', '2024-11-03 16:09:47', '2024-11-03 16:09:47', '2024-11-03 16:09:47', '2024-11-03 16:09:47', '2024-11-03 16:09:47', '2024-11-03 16:09:47', '', NULL, NULL, NULL, NULL, 0, 0);

-- ----------------------------
-- Table structure for block_exception
-- ----------------------------
DROP TABLE IF EXISTS `block_exception`;
CREATE TABLE `block_exception`  (
  `login` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT ''
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of block_exception
-- ----------------------------
INSERT INTO `block_exception` VALUES ('NONE');

-- ----------------------------
-- Table structure for iptocountry
-- ----------------------------
DROP TABLE IF EXISTS `iptocountry`;
CREATE TABLE `iptocountry`  (
  `IP_FROM` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `IP_TO` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `COUNTRY_NAME` varchar(56) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iptocountry
-- ----------------------------
INSERT INTO `iptocountry` VALUES ('0.0.0.0', '0.0.0.0', 'NONE');

-- ----------------------------
-- Table structure for string
-- ----------------------------
DROP TABLE IF EXISTS `string`;
CREATE TABLE `string`  (
  `name` varchar(64) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `text` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of string
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
