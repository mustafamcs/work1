import app
import uiScriptLocale

LOCALE_PATH = uiScriptLocale.LOGIN_PATH
#Big-List
#SERVER_BOARD_HEIGHT = 180 + 390
#SERVER_LIST_HEIGHT = 171 + 350
#Small list like german
SERVER_BOARD_HEIGHT = 220 + 180
SERVER_LIST_HEIGHT = 171 + 180
SERVER_BOARD_WEIGHT = 375 

ID_LIMIT_COUNT = 19
PW_LIMIT_COUNT = 16

window = {
	"name" : "LoginWindow",
	"sytle" : ("movable",),

	"x" : 0,
	"y" : 0,

	"width" : SCREEN_WIDTH,
	"height" : SCREEN_HEIGHT,

	"children" :
	[

		## Board
		{
			"name" : "bg1", "tip" : "expanded_image", "x" : 0, "y" : 0,
			"x_scale" : float(SCREEN_WIDTH) / 1024.0, "y_scale" : float(SCREEN_HEIGHT) / 768.0,
			"image" : "locale/tr/ui/serverlist.sub",
		},
		{
			"name" : "bg2", "tip" : "expanded_image", "x" : 0, "y" : 0,
			"x_scale" : float(SCREEN_WIDTH) / 1024.0, "y_scale" : float(SCREEN_HEIGHT) / 768.0,
			"image" : "locale/tr/ui/login.sub",
		},

		## VirtualKeyboard
		{
			'name' : 'VirtualKeyboard',
			'tip' : 'thinboard',
			'x' : (SCREEN_WIDTH - 564) / 2,
			'y' : SCREEN_HEIGHT - 300,
			'width' : 564,
			'height' : 254,
			'children' : 
			(
				{
					'name' : 'key_at',
					'tip' : 'toggle_button',
					'x' : 40,
					'y' : 186,
					'default_image' : 'locale/tr/ui/vkey/key_at.tga',
					'down_image' : 'locale/tr/ui/vkey/key_at_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_at_over.tga',
				},
				{
					'name' : 'key_backspace',
					'tip' : 'button',
					'x' : 498,
					'y' : 186,
					'default_image' : 'locale/tr/ui/vkey/key_backspace.tga',
					'down_image' : 'locale/tr/ui/vkey/key_backspace_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_backspace_over.tga',
				},
				{
					'name' : 'key_enter',
					'tip' : 'button',
					'x' : 439,
					'y' : 186,
					'default_image' : 'locale/tr/ui/vkey/key_enter.tga',
					'down_image' : 'locale/tr/ui/vkey/key_enter_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_enter_over.tga',
				},
				{
					'name' : 'key_shift',
					'tip' : 'toggle_button',
					'x' : 86,
					'y' : 186,
					'default_image' : 'locale/tr/ui/vkey/key_shift.tga',
					'down_image' : 'locale/tr/ui/vkey/key_shift_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_shift_over.tga',
				},
				{
					'name' : 'key_space',
					'tip' : 'button',
					'x' : 145,
					'y' : 186,
					'default_image' : 'locale/tr/ui/vkey/key_space.tga',
					'down_image' : 'locale/tr/ui/vkey/key_space_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_space_over.tga',
				},
				{
					'name' : 'key_1',
					'tip' : 'button',
					'x' : 40,
					'y' : 24,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_2',
					'tip' : 'button',
					'x' : 80,
					'y' : 24,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_3',
					'tip' : 'button',
					'x' : 120,
					'y' : 24,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_4',
					'tip' : 'button',
					'x' : 160,
					'y' : 24,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_5',
					'tip' : 'button',
					'x' : 200,
					'y' : 24,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_6',
					'tip' : 'button',
					'x' : 240,
					'y' : 24,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_7',
					'tip' : 'button',
					'x' : 280,
					'y' : 24,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_8',
					'tip' : 'button',
					'x' : 320,
					'y' : 24,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_9',
					'tip' : 'button',
					'x' : 360,
					'y' : 24,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_10',
					'tip' : 'button',
					'x' : 400,
					'y' : 24,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_11',
					'tip' : 'button',
					'x' : 440,
					'y' : 24,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_12',
					'tip' : 'button',
					'x' : 480,
					'y' : 24,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_13',
					'tip' : 'button',
					'x' : 40,
					'y' : 63,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_14',
					'tip' : 'button',
					'x' : 80,
					'y' : 63,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_15',
					'tip' : 'button',
					'x' : 120,
					'y' : 63,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_16',
					'tip' : 'button',
					'x' : 160,
					'y' : 63,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_17',
					'tip' : 'button',
					'x' : 200,
					'y' : 63,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_18',
					'tip' : 'button',
					'x' : 240,
					'y' : 63,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_19',
					'tip' : 'button',
					'x' : 280,
					'y' : 63,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_20',
					'tip' : 'button',
					'x' : 320,
					'y' : 63,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_21',
					'tip' : 'button',
					'x' : 360,
					'y' : 63,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_22',
					'tip' : 'button',
					'x' : 400,
					'y' : 63,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_23',
					'tip' : 'button',
					'x' : 440,
					'y' : 63,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_24',
					'tip' : 'button',
					'x' : 480,
					'y' : 63,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_25',
					'tip' : 'button',
					'x' : 60,
					'y' : 104,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_26',
					'tip' : 'button',
					'x' : 100,
					'y' : 104,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_27',
					'tip' : 'button',
					'x' : 140,
					'y' : 104,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_28',
					'tip' : 'button',
					'x' : 180,
					'y' : 104,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_29',
					'tip' : 'button',
					'x' : 220,
					'y' : 104,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_30',
					'tip' : 'button',
					'x' : 260,
					'y' : 104,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_31',
					'tip' : 'button',
					'x' : 300,
					'y' : 104,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_32',
					'tip' : 'button',
					'x' : 340,
					'y' : 104,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_33',
					'tip' : 'button',
					'x' : 380,
					'y' : 104,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_34',
					'tip' : 'button',
					'x' : 420,
					'y' : 104,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_35',
					'tip' : 'button',
					'x' : 460,
					'y' : 104,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_36',
					'tip' : 'button',
					'x' : 60,
					'y' : 144,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_37',
					'tip' : 'button',
					'x' : 100,
					'y' : 144,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_38',
					'tip' : 'button',
					'x' : 140,
					'y' : 144,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_39',
					'tip' : 'button',
					'x' : 180,
					'y' : 144,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_40',
					'tip' : 'button',
					'x' : 220,
					'y' : 144,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_41',
					'tip' : 'button',
					'x' : 260,
					'y' : 144,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_42',
					'tip' : 'button',
					'x' : 300,
					'y' : 144,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_43',
					'tip' : 'button',
					'x' : 340,
					'y' : 144,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_44',
					'tip' : 'button',
					'x' : 380,
					'y' : 144,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_45',
					'tip' : 'button',
					'x' : 420,
					'y' : 144,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
				{
					'name' : 'key_46',
					'tip' : 'button',
					'x' : 460,
					'y' : 144,
					'default_image' : 'locale/tr/ui/vkey/key_normal.tga',
					'down_image' : 'locale/tr/ui/vkey/key_normal_dn.tga',
					'over_image' : 'locale/tr/ui/vkey/key_normal_over.tga',
				},
			)
		},

		## ConnectBoard
		{
			"name" : "ConnectBoard",
			"tip" : "thinboard",

			"x" : (SCREEN_WIDTH - 208) / 2,
			"y" : (SCREEN_HEIGHT - 410 - 35),
			"width" : 208,
			"height" : 30,

			"children" :
			(
				{
					"name" : "ConnectName",
					"tip" : "text",

					"x" : 15,
					"y" : 0,
					"vertical_align" : "center",
					"text_vertical_align" : "center",

					"text" : uiScriptLocale.LOGIN_DEFAULT_SERVERADDR,
				},
				{
					"name" : "SelectConnectButton",
					"tip" : "button",

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

		## LoginBoard
		{
			"name" : "LoginBoard",
			"tip" : "image",

			"x" : (SCREEN_WIDTH - 208) / 2,
			"y" : (SCREEN_HEIGHT - 410),

			"image" : LOCALE_PATH + "loginwindow.sub",

			"children" :
			(
				{ 
					"name" : "ID_Text_window", "tip" : "window", "x" : 45, "y" : 4, "width" : 120, "height" : 18,
					"children" :
					(
						{"name":"ID_Text", "tip":"text", "x":0, "y":0, "text":uiScriptLocale.LOGIN_ID, "all_align" : "center"},
					),	
				},
				
				{ 
					"name" : "Password_Text_window", "tip" : "window", "x" : 45, "y" : 41, "width" : 120, "height" : 18,
					"children" :
					(
						{"name":"Password_Text", "tip":"text", "x":0, "y":0, "text":uiScriptLocale.LOGIN_PASSWORD, "all_align" : "center"},
					),	
				},
				
				{
					"name" : "ID_EditLine",
					"tip" : "editline",

					"x" : 48,
					"y" : 23,

					"width" : 120,
					"height" : 18,

					"input_limit" : ID_LIMIT_COUNT,
					"enable_codepage" : 0,

					"r" : 1.0,
					"g" : 1.0,
					"b" : 1.0,
					"a" : 1.0,
				},
				{
					"name" : "Password_EditLine",
					"tip" : "editline",

					"x" : 48,
					"y" : 60,

					"width" : 120,
					"height" : 18,

					"input_limit" : PW_LIMIT_COUNT,
					"secret_flag" : 1,
					"enable_codepage" : 0,

					"r" : 1.0,
					"g" : 1.0,
					"b" : 1.0,
					"a" : 1.0,
				},
				{
					"name" : "LoginButton",
					"tip" : "button",

					"x" : 15,
					"y" : 79,

					"default_image" : "d:/ymir work/ui/public/large_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/large_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/large_button_03.sub",

					"text" : uiScriptLocale.LOGIN_CONNECT,
				},
				{
					"name" : "LoginExitButton",
					"tip" : "button",

					"x" : 105,
					"y" : 79,

					"default_image" : "d:/ymir work/ui/public/large_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/large_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/large_button_03.sub",

					"text" : uiScriptLocale.LOGIN_EXIT,
				},
			),
		},

		## ServerBoard
		{
			"name" : "ServerBoard",
			"tip" : "thinboard",

			"x" : 0,
			"y" : SCREEN_HEIGHT - SERVER_BOARD_HEIGHT - 72,
			"width" : 375,
			"height" : SERVER_BOARD_HEIGHT,
			"horizontal_align" : "center",

			"children" :
			[

				## Title
				{
					"name" : "Title",
					"tip" : "text",

					"x" : 0,
					"y" : 12,
					"horizontal_align" : "center",
					"text_horizontal_align" : "center",
					"text" : uiScriptLocale.LOGIN_SELECT_TITLE,
				},

				## Horizontal
				{
					"name" : "HorizontalLine1",
					"tip" : "line",

					"x" : 10,
					"y" : 34,
					"width" : 354,
					"height" : 0,
					"color" : 0xff777777,
				},
				{
					"name" : "HorizontalLine2",
					"tip" : "line",

					"x" : 10,
					"y" : 35,
					"width" : 355,
					"height" : 0,
					"color" : 0xff111111,
				},

				## Vertical
				{
					"name" : "VerticalLine1",
					"tip" : "line",

					"x" : 246,
					"y" : 38,
					"width" : 0,
					"height" : SERVER_LIST_HEIGHT + 4,
					"color" : 0xff777777,
				},
				{
					"name" : "VerticalLine2",
					"tip" : "line",

					"x" : 247,
					"y" : 38,
					"width" : 0,
					"height" : SERVER_LIST_HEIGHT + 4,
					"color" : 0xff111111,
				},

				## Buttons
				{
					"name" : "ServerSelectButton",
					"tip" : "button",

					"x" : 267,
					"y" : SERVER_LIST_HEIGHT,

					"default_image" : "d:/ymir work/ui/public/large_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/large_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/large_button_03.sub",

					"text" : uiScriptLocale.OK,
				},
				{
					"name" : "ServerExitButton",
					"tip" : "button",

					"x" : 267,
					"y" : SERVER_LIST_HEIGHT + 22,

					"default_image" : "d:/ymir work/ui/public/large_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/large_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/large_button_03.sub",

					"text" : uiScriptLocale.LOGIN_SELECT_EXIT,
				},

			],

		},

	],
}



if not app.ENABLE_SERVER_SELECT_RENEWAL:
	window["children"][5]["children"] = window["children"][5]["children"] + [
				## ListBox
				{
					"name" : "ServerList",
					"tip" : "listbox2",

					"x" : 10,
					"y" : 40,
					"width" : 232,
					"height" : SERVER_LIST_HEIGHT,
					"row_count" : 15,
					"item_align" : 0,
				},
				{
					"name" : "ChannelList",
					"tip" : "listbox",
					"x" : 255,
					"y" : 40,
					"width" : 109,
					"height" : SERVER_LIST_HEIGHT-40,

					"item_align" : 0,
				},]