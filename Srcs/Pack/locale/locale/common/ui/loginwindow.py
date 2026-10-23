import app
import uiScriptLocale

ID_LIMIT_COUNT = 19
PW_LIMIT_COUNT = 16

# Uc kolon: Kanallar | Giris | Hesaplar. Ayni thinboard, ayni buton.
COL_W = 208
COL_H = 220
GAP = 12
ROW_W = COL_W * 3 + GAP * 2
ORIGIN_X = (SCREEN_WIDTH - ROW_W) / 2
ORIGIN_Y = (SCREEN_HEIGHT - COL_H) / 2

window = {
	"name" : "LoginWindow",
	"sytle" : ("movable",),

	"x" : 0,
	"y" : 0,

	"width" : SCREEN_WIDTH,
	"height" : SCREEN_HEIGHT,

	"children" :
	(

		## Arka plan
		{
			"name" : "bg1", "type" : "expanded_image", "x" : 0, "y" : 0,
			"x_scale" : float(SCREEN_WIDTH) / 1024.0, "y_scale" : float(SCREEN_HEIGHT) / 768.0,
			"image" : "locale/common/ui/serverlist.sub",
		},
		{
			"name" : "bg2", "type" : "expanded_image", "x" : 0, "y" : 0,
			"x_scale" : float(SCREEN_WIDTH) / 1024.0, "y_scale" : float(SCREEN_HEIGHT) / 768.0,
			"image" : "locale/common/ui/login.sub",
		},

		## Sol: kanallar
		{
			"name" : "ServerBoard",
			"type" : "thinboard",

			"x" : ORIGIN_X,
			"y" : ORIGIN_Y,
			"width" : COL_W,
			"height" : COL_H,

			"children" :
			(
				{
					"name" : "ChannelTitle",
					"type" : "text",

					"x" : 0,
					"y" : 8,
					"horizontal_align" : "center",
					"text_horizontal_align" : "center",
					"color" : 0xFFffbf00,
					"outline" : 1,

					"text" : uiScriptLocale.LOGIN_COL_CHANNEL,
				},
				{
					"name" : "ChannelLine",
					"type" : "line",

					"x" : 10,
					"y" : 26,
					"width" : COL_W - 20,
					"height" : 0,
					"color" : 0xff777777,
				},

				## Kod SelectItem icin kullanir; ekranda gizli
				{
					"name" : "ServerList",
					"type" : "listbox2",

					"x" : 8,
					"y" : 34,
					"width" : 40,
					"height" : 20,
					"row_count" : 15,
					"item_align" : 0,
				},
				{
					"name" : "ChannelList",
					"type" : "listbox",

					"x" : 52,
					"y" : 34,
					"width" : 40,
					"height" : 20,
					"item_align" : 0,
				},
				{
					"name" : "ServerSelectButton",
					"type" : "button",

					"x" : 8,
					"y" : 34,

					"default_image" : "d:/ymir work/ui/public/large_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/large_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/large_button_03.sub",

					"text" : uiScriptLocale.OK,
				},
				{
					"name" : "ServerExitButton",
					"type" : "button",

					"x" : 100,
					"y" : 34,

					"default_image" : "d:/ymir work/ui/public/large_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/large_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/large_button_03.sub",

					"text" : uiScriptLocale.LOGIN_SELECT_EXIT,
				},
			),
		},

		## Gizli baglanti cubugu (secili kanal metni kodda duruyor)
		{
			"name" : "ConnectBoard",
			"type" : "thinboard",

			"x" : 0,
			"y" : 0,
			"width" : 208,
			"height" : 30,

			"children" :
			(
				{
					"name" : "ConnectName",
					"type" : "text",

					"x" : 0,
					"y" : 0,
					"all_align" : "center",

					"text" : uiScriptLocale.LOGIN_DEFAULT_SERVERADDR,
				},
				{
					"name" : "SelectConnectButton",
					"type" : "button",

					"x" : 150,
					"y" : 0,
					"vertical_align" : "center",

					"default_image" : "d:/ymir work/ui/public/small_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/small_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/small_button_03.sub",

					"text" : uiScriptLocale.LOGIN_SELECT_BUTTON,
				},
			),
		},

		## Orta: giris
		{
			"name" : "LoginBoard",
			"type" : "thinboard",

			"x" : ORIGIN_X + COL_W + GAP,
			"y" : ORIGIN_Y,
			"width" : COL_W,
			"height" : COL_H,

			"children" :
			(
				{
					"name" : "LoginTitle",
					"type" : "text",

					"x" : 0,
					"y" : 8,
					"horizontal_align" : "center",
					"text_horizontal_align" : "center",
					"color" : 0xFFffbf00,
					"outline" : 1,

					"text" : uiScriptLocale.LOGIN_COL_LOGIN,
				},
				{
					"name" : "LoginLine",
					"type" : "line",

					"x" : 10,
					"y" : 26,
					"width" : COL_W - 20,
					"height" : 0,
					"color" : 0xff777777,
				},
				{
					"name" : "ID_Text",
					"type" : "text",

					"x" : 14,
					"y" : 36,

					"text" : uiScriptLocale.LOGIN_ID,
				},
				{
					"name" : "ID_Slot",
					"type" : "slotbar",

					"x" : 14,
					"y" : 52,
					"width" : 180,
					"height" : 18,

					"children" :
					(
						{
							"name" : "ID_EditLine",
							"type" : "editline",

							"x" : 3,
							"y" : 2,

							"width" : 170,
							"height" : 16,

							"input_limit" : ID_LIMIT_COUNT,
							"enable_codepage" : 0,

							"r" : 1.0,
							"g" : 1.0,
							"b" : 1.0,
							"a" : 1.0,
						},
					),
				},
				{
					"name" : "Password_Text",
					"type" : "text",

					"x" : 14,
					"y" : 78,

					"text" : uiScriptLocale.LOGIN_PASSWORD,
				},
				{
					"name" : "Password_Slot",
					"type" : "slotbar",

					"x" : 14,
					"y" : 94,
					"width" : 180,
					"height" : 18,

					"children" :
					(
						{
							"name" : "Password_EditLine",
							"type" : "editline",

							"x" : 3,
							"y" : 2,

							"width" : 170,
							"height" : 16,

							"input_limit" : PW_LIMIT_COUNT,
							"secret_flag" : 1,
							"enable_codepage" : 0,

							"r" : 1.0,
							"g" : 1.0,
							"b" : 1.0,
							"a" : 1.0,
						},
					),
				},
				{
					"name" : "LoginButton",
					"type" : "button",

					"x" : 14,
					"y" : 128,

					"default_image" : "d:/ymir work/ui/public/xlarge_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/xlarge_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/xlarge_button_03.sub",

					"text" : uiScriptLocale.LOGIN_CONNECT,
				},
				{
					"name" : "LoginExitButton",
					"type" : "button",

					"x" : 14,
					"y" : 158,

					"default_image" : "d:/ymir work/ui/public/xlarge_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/xlarge_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/xlarge_button_03.sub",

					"text" : uiScriptLocale.LOGIN_EXIT,
				},
			),
		},

		## Sag: kayitli hesaplar
		{
			"name" : "SaveAccountBoard",
			"type" : "thinboard",

			"x" : ORIGIN_X + (COL_W + GAP) * 2,
			"y" : ORIGIN_Y,
			"width" : COL_W,
			"height" : COL_H,

			"children" :
			(
				{
					"name" : "SaveAccountTitle",
					"type" : "text",

					"x" : 0,
					"y" : 8,
					"horizontal_align" : "center",
					"text_horizontal_align" : "center",
					"color" : 0xFFffbf00,
					"outline" : 1,

					"text" : uiScriptLocale.LOGIN_COL_ACCOUNT,
				},
				{
					"name" : "SaveAccountLine",
					"type" : "line",

					"x" : 10,
					"y" : 26,
					"width" : COL_W - 20,
					"height" : 0,
					"color" : 0xff777777,
				},
			),
		},

	),
}

if not app.ENABLE_SAVE_ACCOUNT:
	window["children"] = window["children"][:-1]
