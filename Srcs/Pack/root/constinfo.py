import app
import chrmgr
import item
import net
import player

if app.ENABLE_TARGET_INFORMATION_SYSTEM:
	MONSTER_INFO_DATA = {}

# enable save account
if app.ENABLE_SAVE_ACCOUNT:
	class SAB:
		ST_CACHE, ST_FILE, ST_REGISTRY = xrange(3)
		slotCount = 5
		storeType = ST_REGISTRY # 0 cache, 1 file, 2 registry
		btnName = {
			"Save": "SaveAccountButton_Save_%02d",
			"Access": "SaveAccountButton_Access_%02d",
			"Remove": "SaveAccountButton_Remove_%02d",
		}
		accData = {}
		regPath = r"SOFTWARE\Metin2"
		regName = "slot%02d_%s"
		regValueId = "id"
		regValuePwd = "pwd"
		fileExt = ".do.not.share.it.txt"
def CreateSABDataFolder(filePath):
	import os
	folderPath = os.path.split(filePath)[0]
	if not os.path.exists(folderPath):
		os.makedirs(folderPath)
def IsExistSABDataFile(filePath):
	import os
	return os.path.exists(filePath)
def GetSABDataFile(idx):
	import os
	filePath = "%s\\Metin2\\" % os.getenv('appdata')
	filePath += SAB.regName % (idx, SAB.regValueId)
	filePath += SAB.fileExt
	return filePath
def DelJsonSABData(idx):
	import os
	filePath = GetSABDataFile(idx)
	if IsExistSABDataFile(filePath):
		os.remove(filePath)
def GetJsonSABData(idx):
	(id, pwd) = ("", "")
	filePath = GetSABDataFile(idx)
	if not IsExistSABDataFile(filePath):
		return (id, pwd)
	with old_open(filePath) as data_file:
		try:
			import json
			(id, pwd) = json.load(data_file)
			id = str(id) # unicode to ascii
			pwd = str(pwd) # unicode to ascii
		except ValueError:
			pass
	return (id, pwd)
def SetJsonSABData(idx, slotData):
	filePath = GetSABDataFile(idx)
	CreateSABDataFolder(filePath)
	with old_open(filePath, "w") as data_file:
		import json
		json.dump(slotData, data_file)
def DelWinRegKeyValue(keyPath, keyName):
	try:
		import _winreg
		_winreg.CreateKey(_winreg.HKEY_CURRENT_USER, keyPath)
		_tmpKey = _winreg.OpenKey(_winreg.HKEY_CURRENT_USER, keyPath, 0, _winreg.KEY_WRITE)
		_winreg.DeleteValue(_tmpKey, keyName)
		_winreg.CloseKey(_tmpKey)
		return True
	except WindowsError:
		return False
def GetWinRegKeyValue(keyPath, keyName):
	try:
		import _winreg
		_tmpKey = _winreg.OpenKey(_winreg.HKEY_CURRENT_USER, keyPath, 0, _winreg.KEY_READ)
		keyValue, keyType = _winreg.QueryValueEx(_tmpKey, keyName)
		_winreg.CloseKey(_tmpKey)
		return str(keyValue) # unicode to ascii
	except WindowsError:
		return None
def SetWinRegKeyValue(keyPath, keyName, keyValue):
	try:
		import _winreg
		_winreg.CreateKey(_winreg.HKEY_CURRENT_USER, keyPath)
		_tmpKey = _winreg.OpenKey(_winreg.HKEY_CURRENT_USER, keyPath, 0, _winreg.KEY_WRITE)
		_winreg.SetValueEx(_tmpKey, keyName, 0, _winreg.REG_SZ, keyValue)
		_winreg.CloseKey(_tmpKey)
		return True
	except WindowsError:
		return False

# classic minmax def
def minmax(tmin, tmid, tmax):
	if tmid < tmin:
		return tmin
	elif tmid > tmax:
		return tmax
	return tmid
# EXTRA END

# TRADE_GOLD_WITH_THOUSANDS_SEPARATORS BEGIN
def intWithCommas(x, commasign='.'):
	# alternative of
	# return '{0:,}'.format(x).replace(',', commasign)
	if type(x) not in [type(0), type(0L)]:
		raise TypeError("Parametre tam sayı olmalı.")
	if x < 0:
		return '-' + intWithCommas(-x, commasign)
	result = ''
	while x >= 1000:
		x, r = divmod(x, 1000)
		result = "%s%03d%s" % (commasign, r, result)
	return "%d%s" % (x, result)
# TRADE_GOLD_WITH_THOUSANDS_SEPARATORS END

def Emoji(path):
	return "|E{}|e".format(path)

def Color(hexString):
	return "|cff{}|h".format(hexString)

def TextColor(text, hexString):
	return "|cff{}|h{}|r".format(hexString, text)

# option
IN_GAME_SHOP_ENABLE = app.IN_GAME_SHOP_ENABLE
CONSOLE_ENABLE = app.CONSOLE_ENABLE

PVPMODE_ENABLE = app.PVPMODE_ENABLE
PVPMODE_TEST_ENABLE = app.PVPMODE_TEST_ENABLE
PVPMODE_ACCELKEY_ENABLE = app.PVPMODE_ACCELKEY_ENABLE
PVPMODE_ACCELKEY_DELAY = app.PVPMODE_ACCELKEY_DELAY
PVPMODE_PROTECTED_LEVEL = app.PVPMODE_PROTECTED_LEVEL

FOG_LEVEL0 = app.FOG_LEVEL0
FOG_LEVEL1 = app.FOG_LEVEL1
FOG_LEVEL2 = app.FOG_LEVEL2
FOG_LEVEL = app.FOG_LEVEL0
FOG_LEVEL_LIST=[FOG_LEVEL0, FOG_LEVEL1, FOG_LEVEL2]

CAMERA_MAX_DISTANCE_SHORT = app.CAMERA_MAX_DISTANCE_SHORT
CAMERA_MAX_DISTANCE_LONG = app.CAMERA_MAX_DISTANCE_LONG
CAMERA_MAX_DISTANCE_LIST=[CAMERA_MAX_DISTANCE_SHORT, CAMERA_MAX_DISTANCE_LONG]
CAMERA_MAX_DISTANCE = app.CAMERA_MAX_DISTANCE_SHORT

CHRNAME_COLOR_INDEX = app.CHRNAME_COLOR_INDEX

ENVIRONMENT_NIGHT = app.ENVIRONMENT_NIGHT

# constant
HIGH_PRICE = app.HIGH_PRICE
MIDDLE_PRICE = app.MIDDLE_PRICE
ERROR_METIN_STONE = app.ERROR_METIN_STONE
SUB2_LOADING_ENABLE = app.SUB2_LOADING_ENABLE
EXPANDED_COMBO_ENABLE = app.EXPANDED_COMBO_ENABLE
CONVERT_EMPIRE_LANGUAGE_ENABLE = app.CONVERT_EMPIRE_LANGUAGE_ENABLE
USE_ITEM_WEAPON_TABLE_ATTACK_BONUS = app.USE_ITEM_WEAPON_TABLE_ATTACK_BONUS
ADD_DEF_BONUS_ENABLE = app.ADD_DEF_BONUS_ENABLE
LOGIN_COUNT_LIMIT_ENABLE = app.LOGIN_COUNT_LIMIT_ENABLE

USE_SKILL_EFFECT_UPGRADE_ENABLE = app.USE_SKILL_EFFECT_UPGRADE_ENABLE

VIEW_OTHER_EMPIRE_PLAYER_TARGET_BOARD = app.VIEW_OTHER_EMPIRE_PLAYER_TARGET_BOARD
GUILD_MONEY_PER_GSP = app.GUILD_MONEY_PER_GSP
GUILD_WAR_TYPE_SELECT_ENABLE = app.GUILD_WAR_TYPE_SELECT_ENABLE
TWO_HANDED_WEAPON_ATT_SPEED_DECREASE_VALUE = app.TWO_HANDED_WEAPON_ATT_SPEED_DECREASE_VALUE

HAIR_COLOR_ENABLE = app.HAIR_COLOR_ENABLE
ARMOR_SPECULAR_ENABLE = app.ARMOR_SPECULAR_ENABLE
WEAPON_SPECULAR_ENABLE = app.WEAPON_SPECULAR_ENABLE
SEQUENCE_PACKET_ENABLE = app.SEQUENCE_PACKET_ENABLE
KEEP_ACCOUNT_CONNETION_ENABLE = app.KEEP_ACCOUNT_CONNETION_ENABLE
MINIMAP_POSITIONINFO_ENABLE = app.MINIMAP_POSITIONINFO_ENABLE

isItemQuestionDialog = 0

def GET_ITEM_QUESTION_DIALOG_STATUS():
	global isItemQuestionDialog
	return isItemQuestionDialog

def SET_ITEM_QUESTION_DIALOG_STATUS(flag):
	global isItemQuestionDialog
	isItemQuestionDialog = flag

########################

def SET_DEFAULT_FOG_LEVEL():
	global FOG_LEVEL
	app.SetMinFog(FOG_LEVEL)

def SET_FOG_LEVEL_INDEX(index):
	global FOG_LEVEL
	global FOG_LEVEL_LIST
	try:
		FOG_LEVEL=FOG_LEVEL_LIST[index]
	except IndexError:
		FOG_LEVEL=FOG_LEVEL_LIST[0]
	app.SetMinFog(FOG_LEVEL)

def GET_FOG_LEVEL_INDEX():
	global FOG_LEVEL
	global FOG_LEVEL_LIST
	return FOG_LEVEL_LIST.index(FOG_LEVEL)

########################

def SET_DEFAULT_CAMERA_MAX_DISTANCE():
	global CAMERA_MAX_DISTANCE
	app.SetCameraMaxDistance(CAMERA_MAX_DISTANCE)

def SET_CAMERA_MAX_DISTANCE_INDEX(index):
	global CAMERA_MAX_DISTANCE
	global CAMERA_MAX_DISTANCE_LIST
	try:
		CAMERA_MAX_DISTANCE=CAMERA_MAX_DISTANCE_LIST[index]
	except:
		CAMERA_MAX_DISTANCE=CAMERA_MAX_DISTANCE_LIST[0]

	app.SetCameraMaxDistance(CAMERA_MAX_DISTANCE)

def GET_CAMERA_MAX_DISTANCE_INDEX():
	global CAMERA_MAX_DISTANCE
	global CAMERA_MAX_DISTANCE_LIST
	return CAMERA_MAX_DISTANCE_LIST.index(CAMERA_MAX_DISTANCE)

########################

def SET_DEFAULT_CHRNAME_COLOR():
	global CHRNAME_COLOR_INDEX
	chrmgr.SetEmpireNameMode(CHRNAME_COLOR_INDEX)

def SET_CHRNAME_COLOR_INDEX(index):
	global CHRNAME_COLOR_INDEX
	CHRNAME_COLOR_INDEX=index
	chrmgr.SetEmpireNameMode(index)

def GET_CHRNAME_COLOR_INDEX():
	global CHRNAME_COLOR_INDEX
	return CHRNAME_COLOR_INDEX

def SET_VIEW_OTHER_EMPIRE_PLAYER_TARGET_BOARD(index):
	global VIEW_OTHER_EMPIRE_PLAYER_TARGET_BOARD
	VIEW_OTHER_EMPIRE_PLAYER_TARGET_BOARD = index

def GET_VIEW_OTHER_EMPIRE_PLAYER_TARGET_BOARD():
	global VIEW_OTHER_EMPIRE_PLAYER_TARGET_BOARD
	return VIEW_OTHER_EMPIRE_PLAYER_TARGET_BOARD

def SET_DEFAULT_CONVERT_EMPIRE_LANGUAGE_ENABLE():
	global CONVERT_EMPIRE_LANGUAGE_ENABLE
	net.SetEmpireLanguageMode(CONVERT_EMPIRE_LANGUAGE_ENABLE)

def SET_DEFAULT_USE_ITEM_WEAPON_TABLE_ATTACK_BONUS():
	global USE_ITEM_WEAPON_TABLE_ATTACK_BONUS
	player.SetWeaponAttackBonusFlag(USE_ITEM_WEAPON_TABLE_ATTACK_BONUS)

def SET_DEFAULT_USE_SKILL_EFFECT_ENABLE():
	global USE_SKILL_EFFECT_UPGRADE_ENABLE
	app.SetSkillEffectUpgradeEnable(USE_SKILL_EFFECT_UPGRADE_ENABLE)

def SET_TWO_HANDED_WEAPON_ATT_SPEED_DECREASE_VALUE():
	global TWO_HANDED_WEAPON_ATT_SPEED_DECREASE_VALUE
	app.SetTwoHandedWeaponAttSpeedDecreaseValue(TWO_HANDED_WEAPON_ATT_SPEED_DECREASE_VALUE)

########################

ACCESSORY_MATERIAL_LIST = [50623, 50624, 50625, 50626, 50627, 50628, 50629, 50630, 50631, 50632, 50633, 50634, 50635, 50636, 50637, 50638, 50639]
JewelAccessoryInfos = [
		# jewel		wrist	neck	ear
		[ 50634,	14420,	16220,	17220 ],
		[ 50635,	14500,	16500,	17500 ],
		[ 50636,	14520,	16520,	17520 ],
		[ 50637,	14540,	16540,	17540 ],
		[ 50638,	14560,	16560,	17560 ],
		[ 50639,	14570,	16570,	17570 ],
	]
def GET_ACCESSORY_MATERIAL_VNUM(vnum, subType):
	ret = vnum
	item_base = (vnum / 10) * 10
	for info in JewelAccessoryInfos:
		if item.ARMOR_WRIST == subType:
			if info[1] == item_base:
				return info[0]
		elif item.ARMOR_NECK == subType:
			if info[2] == item_base:
				return info[0]
		elif item.ARMOR_EAR == subType:
			if info[3] == item_base:
				return info[0]

	if vnum >= 16210 and vnum <= 16219:
		return 50625

	if item.ARMOR_WRIST == subType:
		WRIST_ITEM_VNUM_BASE = 14000
		ret -= WRIST_ITEM_VNUM_BASE
	elif item.ARMOR_NECK == subType:
		NECK_ITEM_VNUM_BASE = 16000
		ret -= NECK_ITEM_VNUM_BASE
	elif item.ARMOR_EAR == subType:
		EAR_ITEM_VNUM_BASE = 17000
		ret -= EAR_ITEM_VNUM_BASE

	type = ret/20

	if type<0 or type>=len(ACCESSORY_MATERIAL_LIST):
		type = (ret-170) / 20
		if type<0 or type>=len(ACCESSORY_MATERIAL_LIST):
			return 0

	return ACCESSORY_MATERIAL_LIST[type]

##################################################################

def GET_BELT_MATERIAL_VNUM(vnum, subType = 0):
	return 18900

##################################################################

def IS_AUTO_POTION(itemVnum):
	return IS_AUTO_POTION_HP(itemVnum) or IS_AUTO_POTION_SP(itemVnum)

def IS_AUTO_POTION_HP(itemVnum):
	if 72723 <= itemVnum and 72726 >= itemVnum:
		return 1
	elif itemVnum >= 76021 and itemVnum <= 76022:
		return 1
	elif itemVnum == 79012:
		return 1

	return 0

def IS_AUTO_POTION_SP(itemVnum):
	if 72727 <= itemVnum and 72730 >= itemVnum:
		return 1
	elif itemVnum >= 76004 and itemVnum <= 76005:
		return 1
	elif itemVnum == 79013:
		return 1

	return 0

def IS_PET_SEAL(itemVnum):
	if not app.ENABLE_PET_SYSTEM_EX:
		return False
	item.SelectItem(itemVnum)
	itemType = item.GetItemType()
	# itemSubType = item.GetItemSubType()
	return item.ITEM_TYPE_PET == itemType
