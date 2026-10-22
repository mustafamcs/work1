import app
import pack
import os

AUTOBAN_QUIZ_ANSWER = "CEVAP"
AUTOBAN_QUIZ_REFRESH = "YENİLE"
AUTOBAN_QUIZ_REST_TIME = "KALAN SÜRE"

OPTION_SHADOW = "GÖLGE"

CODEPAGE = str(app.GetDefaultCodePage())

def _ui_utf8_to_cp1254(data):
	if len(data) >= 3 and data[0] == '\xef' and data[1] == '\xbb' and data[2] == '\xbf':
		data = data[3:]
	result = ""
	i = 0
	while i < len(data):
		c = ord(data[i])
		if c < 0x80:
			result += data[i]
			i += 1
		elif (c & 0xE0) == 0xC0 and i + 1 < len(data) and (ord(data[i+1]) & 0xC0) == 0x80:
			cp = ((c & 0x1F) << 6) | (ord(data[i+1]) & 0x3F)
			m = {0x011E:'\xd0',0x011F:'\xf0',0x0130:'\xdd',0x0131:'\xfd',0x015E:'\xde',0x015F:'\xfe',0x00C7:'\xc7',0x00E7:'\xe7',0x00D6:'\xd6',0x00F6:'\xf6',0x00DC:'\xdc',0x00FC:'\xfc'}
			result += m.get(cp, chr(cp) if cp <= 0xFF else '?')
			i += 2
		elif (c & 0xF0) == 0xE0 and i + 2 < len(data) and (ord(data[i+1]) & 0xC0) == 0x80 and (ord(data[i+2]) & 0xC0) == 0x80:
			cp = ((c & 0x0F) << 12) | ((ord(data[i+1]) & 0x3F) << 6) | (ord(data[i+2]) & 0x3F)
			m = {0x011E:'\xd0',0x011F:'\xf0',0x0130:'\xdd',0x0131:'\xfd',0x015E:'\xde',0x015F:'\xfe',0x00C7:'\xc7',0x00E7:'\xe7',0x00D6:'\xd6',0x00F6:'\xf6',0x00DC:'\xdc',0x00FC:'\xfc',0x20AC:'\x80'}
			result += m.get(cp, chr(cp) if cp <= 0xFF else '?')
			i += 3
		else:
			result += data[i]
			i += 1
	return result

if app.__BL_MULTI_LANGUAGE__:
	def LoadLocaleFile(srcFileName):
		localeDict = {}
		localeDict["CUBE_INFO_TITLE"] = "Tarif"
		localeDict["CUBE_REQUIRE_MATERIAL"] = "Gerekenler"
		localeDict["CUBE_REQUIRE_MATERIAL_OR"] = "veya"

		try:
			f = open(srcFileName, "rb")
			data = f.read()
			f.close()
			if app.GetDefaultCodePage() == 65001:
				if len(data) >= 3 and data[0] == '\xef' and data[1] == '\xbb' and data[2] == '\xbf':
					data = data[3:]
			else:
				data = _ui_utf8_to_cp1254(data)
			lines = data.split("\n")
		except IOError:
			import dbg
			dbg.LogBox("LoadUIScriptLocaleError(%(srcFileName)s)" % localeDict)
			app.Abort()

		for line in lines:
			tokens = line.rstrip("\r").split("\t")

			if len(tokens) >= 2:
				localeDict[tokens[0]] = tokens[1]

			else:
				print(len(tokens), lines.index(line), line)

		globals().update(localeDict)

	def ReloadLocaleFile():
		global CODEPAGE
		CODEPAGE = str(app.GetDefaultCodePage())

		global __IS_ARABIC
		__IS_ARABIC	= "locale/ae" == app.GetLocalePath()

		global LOCALE_UISCRIPT_PATH, LOGIN_PATH, EMPIRE_PATH, GUILD_PATH, SELECT_PATH, WINDOWS_PATH, MAPNAME_PATH
		if app.ENABLE_LOCALE_COMMON and not __IS_ARABIC:
			LOCALE_UISCRIPT_PATH = "locale/common/ui/"
		else:
			LOCALE_UISCRIPT_PATH = "%s/ui/" % (app.GetLocalePath())
		LOGIN_PATH = "%s/ui/login/" % (app.GetLocalePath())
		EMPIRE_PATH = "%s/ui/empire/" % (app.GetLocalePath())
		if app.ENABLE_LOCALE_COMMON and not __IS_ARABIC:
			GUILD_PATH = "locale/common/ui/guild/"
		else:
			GUILD_PATH = "%s/ui/guild/" % (app.GetLocalePath())
		SELECT_PATH = "%s/ui/select/" % (app.GetLocalePath())
		WINDOWS_PATH = "%s/ui/windows/" % (app.GetLocalePath())
		MAPNAME_PATH = "%s/ui/mapname/" % (app.GetLocalePath())

		global JOBDESC_WARRIOR_PATH, JOBDESC_ASSASSIN_PATH, JOBDESC_SURA_PATH, JOBDESC_SHAMAN_PATH
		JOBDESC_WARRIOR_PATH = "%s/jobdesc_warrior.txt" % (app.GetLocalePath())
		JOBDESC_ASSASSIN_PATH = "%s/jobdesc_assassin.txt" % (app.GetLocalePath())
		JOBDESC_SURA_PATH = "%s/jobdesc_sura.txt" % (app.GetLocalePath())
		JOBDESC_SHAMAN_PATH = "%s/jobdesc_shaman.txt" % (app.GetLocalePath())

		global EMPIREDESC_A, EMPIREDESC_B, EMPIREDESC_C
		EMPIREDESC_A = "%s/empiredesc_a.txt" % (app.GetLocalePath())
		EMPIREDESC_B = "%s/empiredesc_b.txt" % (app.GetLocalePath())
		EMPIREDESC_C = "%s/empiredesc_c.txt" % (app.GetLocalePath())

		global LOCALE_INTERFACE_FILE_NAME
		LOCALE_INTERFACE_FILE_NAME = "%s/locale_interface.txt" % (app.GetLocalePath())

		LoadLocaleFile(LOCALE_INTERFACE_FILE_NAME)

		if app.ENABLE_LOCALE_COMMON:
			def TryLoadLocaleFile(filename):
				if pack.Exist(filename) or os.path.exists(filename):
					LoadLocaleFile(filename)
			TryLoadLocaleFile("locale/common/locale_interface_ex.txt")
			TryLoadLocaleFile("%s/locale_interface_ex.txt" % app.GetLocalePath())
			if app.__BL_MULTI_LANGUAGE__:
				TryLoadLocaleFile("%s/locale_interface_maliml.txt" % app.GetLocalePath())

		global LOCALE_NAME_DICT
		LOCALE_NAME_DICT = {
			"tr" : globals()['LANGUAGE_TR'],
		}

else:
	def LoadLocaleFile(srcFileName, localeDict):
		localeDict["CUBE_INFO_TITLE"] = "Tarif"
		localeDict["CUBE_REQUIRE_MATERIAL"] = "Gerekenler"
		localeDict["CUBE_REQUIRE_MATERIAL_OR"] = "veya"

		try:
			f = open(srcFileName, "rb")
			data = f.read()
			f.close()
			# UTF-8 BOM kaldir ve cp1254'e cevir
			if len(data) >= 3 and data[0] == '\xef' and data[1] == '\xbb' and data[2] == '\xbf':
				data = data[3:]
			result = ""
			i = 0
			while i < len(data):
				c = ord(data[i])
				if c < 0x80:
					result += data[i]
					i += 1
				elif (c & 0xE0) == 0xC0 and i + 1 < len(data) and (ord(data[i+1]) & 0xC0) == 0x80:
					cp = ((c & 0x1F) << 6) | (ord(data[i+1]) & 0x3F)
					m = {0x011E:'\xd0',0x011F:'\xf0',0x0130:'\xdd',0x0131:'\xfd',0x015E:'\xde',0x015F:'\xfe',0x00C7:'\xc7',0x00E7:'\xe7',0x00D6:'\xd6',0x00F6:'\xf6',0x00DC:'\xdc',0x00FC:'\xfc'}
					result += m.get(cp, chr(cp) if cp <= 0xFF else '?')
					i += 2
				elif (c & 0xF0) == 0xE0 and i + 2 < len(data) and (ord(data[i+1]) & 0xC0) == 0x80 and (ord(data[i+2]) & 0xC0) == 0x80:
					cp = ((c & 0x0F) << 12) | ((ord(data[i+1]) & 0x3F) << 6) | (ord(data[i+2]) & 0x3F)
					m = {0x011E:'\xd0',0x011F:'\xf0',0x0130:'\xdd',0x0131:'\xfd',0x015E:'\xde',0x015F:'\xfe',0x00C7:'\xc7',0x00E7:'\xe7',0x00D6:'\xd6',0x00F6:'\xf6',0x00DC:'\xdc',0x00FC:'\xfc',0x20AC:'\x80'}
					result += m.get(cp, chr(cp) if cp <= 0xFF else '?')
					i += 3
				else:
					result += data[i]
					i += 1
			lines = result.split("\n")
		except IOError:
			import dbg
			dbg.LogBox("LoadUIScriptLocaleError(%(srcFileName)s)" % locals())
			app.Abort()

		for line in lines:
			tokens = line[:-1].split("\t")

			if len(tokens) >= 2:
				localeDict[tokens[0]] = tokens[1]

			else:
				print(len(tokens), lines.index(line), line)

name = app.GetLocalePath()

__IS_ARABIC		= "locale/ae" == app.GetLocalePath()
if app.ENABLE_LOCALE_COMMON and not __IS_ARABIC:
	LOCALE_UISCRIPT_PATH = "locale/common/ui/"
else:
	LOCALE_UISCRIPT_PATH = "%s/ui/" % (name)
LOGIN_PATH = "%s/ui/login/" % (name)
EMPIRE_PATH = "%s/ui/empire/" % (name)
if app.ENABLE_LOCALE_COMMON and not __IS_ARABIC:
	GUILD_PATH = "locale/common/ui/guild/"
else:
	GUILD_PATH = "%s/ui/guild/" % (name)
SELECT_PATH = "%s/ui/select/" % (name)
WINDOWS_PATH = "%s/ui/windows/" % (name)
MAPNAME_PATH = "%s/ui/mapname/" % (name)

JOBDESC_WARRIOR_PATH = "%s/jobdesc_warrior.txt" % (name)
JOBDESC_ASSASSIN_PATH = "%s/jobdesc_assassin.txt" % (name)
JOBDESC_SURA_PATH = "%s/jobdesc_sura.txt" % (name)
JOBDESC_SHAMAN_PATH = "%s/jobdesc_shaman.txt" % (name)

EMPIREDESC_A = "%s/empiredesc_a.txt" % (name)
EMPIREDESC_B = "%s/empiredesc_b.txt" % (name)
EMPIREDESC_C = "%s/empiredesc_c.txt" % (name)

LOCALE_INTERFACE_FILE_NAME = "%s/locale_interface.txt" % (name)
if app.__BL_MULTI_LANGUAGE__:
	LoadLocaleFile(LOCALE_INTERFACE_FILE_NAME)
else:
	LoadLocaleFile(LOCALE_INTERFACE_FILE_NAME, locals())
if app.ENABLE_LOCALE_COMMON:
	def TryLoadLocaleFile(filename):
		if pack.Exist(filename) or os.path.exists(filename):
			if app.__BL_MULTI_LANGUAGE__:
				LoadLocaleFile(filename)
			else:
				LoadLocaleFile(filename, globals())
	TryLoadLocaleFile("locale/common/locale_interface_ex.txt")
	TryLoadLocaleFile("%s/locale_interface_ex.txt" % app.GetLocalePath())
	if app.__BL_MULTI_LANGUAGE__:
		TryLoadLocaleFile("%s/locale_interface_maliml.txt" % app.GetLocalePath())

if app.__BL_MULTI_LANGUAGE__:
	LOCALE_NAME_DICT = {
		"tr" : globals()['LANGUAGE_TR'],
	}
