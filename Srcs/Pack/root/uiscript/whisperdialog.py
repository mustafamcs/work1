import uiScriptLocale

ROOT = "d:/ymir work/ui/public/"

window = {
	"name" : "WhisperDialog",
	"style" : ("movable", "float",),

	"x" : 0,
	"y" : 0,

	"width" : 280,
	"height" : 200,

	"children" :
	(
		{
			"name" : "board",
			"tip" : "thinboard",
			"style" : ("attach",),

			"x" : 0,
			"y" : 0,

			"width" : 280,
			"height" : 200,

			"children" :
			(
				## Title
				{
					"name" : "name_slot",
					"tip" : "image",
					"style" : ("attach",),

					"x" : 10,
					"y" : 10,

					"image":"d:/ymir work/ui/public/Parameter_Slot_05.sub",

					"children" :
					(
						{
							"name" : "titlename",
							"tip" : "text",

							"x" : 3,
							"y" : 3,

							"text" : uiScriptLocale.WHISPER_NAME,
						},
						{
							"name" : "titlename_edit",
							"tip" : "editline",

							"x" : 3,
							"y" : 3,

							"width" : 120,
							"height" : 17,

							"input_limit" : PLAYER_NAME_MAX_LEN,

							"text" : uiScriptLocale.WHISPER_NAME,
						},
					),
				},

				{
					"name" : "gamemastermark",
					"tip" : "expanded_image",
					"style" : ("attach",),

					"x" : 206,
					"y" : 6,

					"x_scale" : 0.2,
					"y_scale" : 0.2,

					"image" : LOCALE_PATH + "/effect/ymirred.tga",
				},

				## Button
				{
					"name" : "ignorebutton",
					"tip" : "toggle_button",

					"x" : 145,
					"y" : 10,

					"text" : uiScriptLocale.WHISPER_BAN,

					"default_image" : "d:/ymir work/ui/public/small_thin_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/small_thin_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/small_thin_button_03.sub",
				},
				{
					"name" : "reportviolentwhisperbutton",
					"tip" : "button",

					"x" : 145,
					"y" : 10,

					"text" : uiScriptLocale.WHISPER_REPORT,

					"default_image" : "d:/ymir work/ui/public/large_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/large_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/large_button_03.sub",
				},
				{
					"name" : "acceptbutton",
					"tip" : "button",

					"x" : 145,
					"y" : 10,

					"text" : uiScriptLocale.OK,

					"default_image" : "d:/ymir work/ui/public/small_thin_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/small_thin_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/small_thin_button_03.sub",
				},
				{
					"name" : "minimizebutton",
					"tip" : "button",

					"x" : 280 - 41,
					"y" : 12,

					"tooltip_text" : uiScriptLocale.MINIMIZE,

					"default_image" : "d:/ymir work/ui/public/minimize_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/minimize_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/minimize_button_03.sub",
				},
				{
					"name" : "closebutton",
					"tip" : "button",

					"x" : 280 - 24,
					"y" : 12,

					"tooltip_text" : uiScriptLocale.CLOSE,

					"default_image" : "d:/ymir work/ui/public/close_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/close_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/close_button_03.sub",
				},

				## ScrollBar
				{
					"name" : "scrollbar",
					"tip" : "thin_scrollbar",

					"x" : 280 - 25,
					"y" : 35,

					"size" : 280 - 160,
				},

				## Edit Bar
				{
					"name" : "editbar",
					"tip" : "bar",

					"x" : 10,
					"y" : 200 - 60,

					"width" : 280 - 18,
					"height" : 50,

					"color" : 0x77000000,

					"children" :
					(
						{
							"name" : "chatline",
							"tip" : "editline",

							"x" : 5,
							"y" : 5,

							"width" : 280 - 70,
							"height" : 40,

							"with_codepage" : 1,
							"input_limit" : 40,
							"limit_width" : 280 - 90,
							"multi_line" : 1,
						},
						{
							"name" : "sendbutton",
							"tip" : "button",

							"x" : 280 - 80,
							"y" : 10,

							"text" : uiScriptLocale.WHISPER_SEND,

							"default_image" : "d:/ymir work/ui/public/xlarge_thin_button_01.sub",
							"over_image" : "d:/ymir work/ui/public/xlarge_thin_button_02.sub",
							"down_image" : "d:/ymir work/ui/public/xlarge_thin_button_03.sub",
						},
					),
				},
			),
		},
	),
}
