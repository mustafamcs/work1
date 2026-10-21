import app
import localeInfo
from constInfo import TextColor
app.ServerName = None

SRV1 = {
	"name":TextColor("MCS", "ffd500"), #GOLD
	"host":"127.0.0.1",
	"auth1":30001,
	"ch1":30003,
	# tek kanal aktif; ileride acilirsa: "ch2":30023, "ch3":30043, "ch4":30063
	# kaynak: "ch99":30901,
}

STATE_NONE = TextColor(localeInfo.CHANNEL_STATUS_OFFLINE, "FF0000") #RED

STATE_DICT = {
	0: TextColor(localeInfo.CHANNEL_STATUS_OFFLINE, "FF0000"), #RED
	1: TextColor(localeInfo.CHANNEL_STATUS_RECOMMENDED, "00ff00"), #GREEN
	2: TextColor(localeInfo.CHANNEL_STATUS_BUSY, "ffff00"), #YELLOW
	3: TextColor(localeInfo.CHANNEL_STATUS_FULL, "ff8a08") #ORANGE
}

SERVER1_CHANNEL_DICT = {
	0: {"key":10, "name":TextColor("CH-1", "FFffFF"), "ip":SRV1["host"], "tcp_port":SRV1["ch1"], "udp_port":SRV1["ch1"], "state":STATE_NONE,},
	# ileride acilacak kanallar:
	# 1: {"key":11, "name":TextColor("CH-2", "FFffFF"), "ip":SRV1["host"], "tcp_port":30023, "udp_port":30023, "state":STATE_NONE,},
	# 2: {"key":12, "name":TextColor("CH-3", "FFffFF"), "ip":SRV1["host"], "tcp_port":30043, "udp_port":30043, "state":STATE_NONE,},
	# 3: {"key":13, "name":TextColor("CH-4", "FFffFF"), "ip":SRV1["host"], "tcp_port":30063, "udp_port":30063, "state":STATE_NONE,},
	# kaynak: 4: {"key":14, "name":TextColor("CH-99", "FFffFF"), "ip":SRV1["host"], "tcp_port":SRV1["ch99"], "udp_port":SRV1["ch99"], "state":STATE_NONE,},
}

REGION_NAME_DICT = {
	0: SRV1["name"],
}

REGION_AUTH_SERVER_DICT = {
	0: {
		0: {"ip": SRV1["host"], "port": SRV1["auth1"],},
		1: {"ip": SRV1["host"], "port": SRV1["auth1"],},
		2: {"ip": SRV1["host"], "port": SRV1["auth1"],},
		3: {"ip": SRV1["host"], "port": SRV1["auth1"],},
	}
}

REGION_DICT = {
	0: {
		1: {"name": SRV1["name"], "channel": SERVER1_CHANNEL_DICT,},
	},
}

MARKADDR_DICT = {
	10: {"ip": SRV1["host"], "tcp_port": SRV1["ch1"], "mark": "10.tga", "symbol_path": "10",},
}

TESTADDR = {"ip": SRV1["host"], "tcp_port": SRV1["ch1"], "udp_port": SRV1["ch1"],}

if app.__BL_MULTI_LANGUAGE__:
	def ReloadVariables():
		global STATE_NONE
		STATE_NONE = TextColor(localeInfo.CHANNEL_STATUS_OFFLINE, "FF0000") #RED

		global STATE_DICT
		STATE_DICT = {
			0: TextColor(localeInfo.CHANNEL_STATUS_OFFLINE, "FF0000"), #RED
			1: TextColor(localeInfo.CHANNEL_STATUS_RECOMMENDED, "00ff00"), #GREEN
			2: TextColor(localeInfo.CHANNEL_STATUS_BUSY, "ffff00"), #YELLOW
			3: TextColor(localeInfo.CHANNEL_STATUS_FULL, "ff8a08") #ORANGE
		}
