import uiScriptLocale

ROOT_PATH = "d:/ymir work/ui/game/guild/"
LOCALE_PATH = uiScriptLocale.GUILD_PATH

window = {
	"name" : "GuildWindow",
	"style" : ("movable", "float",),

	"x" : 0,
	"y" : 0,

	"width" : 376,
	"height" : 356,

	"children" :
	(
		{
			"name" : "Board",
			"tip" : "board_with_titlebar",

			"x" : 0,
			"y" : 0,

			"width" : 376,
			"height" : 356,

			"title" : uiScriptLocale.GUILD_NAME,

			"children" :
			(
				## Tab Area
				{
					"name" : "TabControl",
					"tip" : "window",

					"x" : 0,
					"y" : 328,

					"width" : 376,
					"height" : 37,

					"children" :
					(
						## Tab
						{
							"name" : "Tab_01",
							"tip" : "image",

							"x" : 0,
							"y" : 0,

							"width" : 376,
							"height" : 37,

							"image" : LOCALE_PATH+"tab_1.sub",
						},
						{
							"name" : "Tab_02",
							"tip" : "image",

							"x" : 0,
							"y" : 0,

							"width" : 376,
							"height" : 37,

							"image" : LOCALE_PATH+"tab_2.sub",
						},
						{
							"name" : "Tab_03",
							"tip" : "image",

							"x" : 0,
							"y" : 0,

							"width" : 376,
							"height" : 37,

							"image" : LOCALE_PATH+"tab_3.sub",
						},
						{
							"name" : "Tab_04",
							"tip" : "image",

							"x" : 0,
							"y" : 0,

							"width" : 376,
							"height" : 37,

							"image" : LOCALE_PATH+"tab_4.sub",
						},
						{
							"name" : "Tab_05",
							"tip" : "image",

							"x" : 0,
							"y" : 0,

							"width" : 376,
							"height" : 37,

							"image" : LOCALE_PATH+"tab_5.sub",
						},
						{
							"name" : "Tab_06",
							"tip" : "image",

							"x" : 0,
							"y" : 0,

							"width" : 376,
							"height" : 37,

							"image" : LOCALE_PATH+"tab_6.sub",
						},
						## RadioButton
						{
							"name" : "Tab_Button_01",
							"tip" : "radio_button",

							"x" : 6,
							"y" : 5,

							"width" : 53,
							"height" : 27,
						},
						{
							"name" : "Tab_Button_02",
							"tip" : "radio_button",

							"x" : 61,
							"y" : 5,

							"width" : 67,
							"height" : 27,
						},
						{
							"name" : "Tab_Button_03",
							"tip" : "radio_button",

							"x" : 130,
							"y" : 5,

							"width" : 60,
							"height" : 27,
						},
						{
							"name" : "Tab_Button_04",
							"tip" : "radio_button",

							"x" : 192,
							"y" : 5,

							"width" : 60,
							"height" : 27,
						},
						{
							"name" : "Tab_Button_05",
							"tip" : "radio_button",

							"x" : 254,
							"y" : 5,

							"width" : 60,
							"height" : 27,
						},
						{
							"name" : "Tab_Button_06",
							"tip" : "radio_button",

							"x" : 316,
							"y" : 5,

							"width" : 55,
							"height" : 27,
						},
					),
				},

			),
		},
	),
}
