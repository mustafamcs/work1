import uiScriptLocale

window = {
	"name" : "AttachStoneDialog",
	"style" : ("movable", "float",),

	"x" : 0,
	"y" : 0,

	"width" : 0,
	"height" : 0,

	"children" :
	(
		{
			"name" : "Board",
			"tip" : "board",
			"style" : ("attach",),

			"x" : 0,
			"y" : 0,

			"width" : 0,
			"height" : 0,
			"children" :
			(
				{
					"name" : "TitleBar",
					"tip" : "titlebar",
					"style" : ("attach",),

					"x" : 8,
					"y" : 8,

					"width" : 0,
					"color" : "red",

					"children" :
					(
						{
							"name" : "TitleName",
							"tip" : "text",
							"text" : uiScriptLocale.ATTACH_METIN_TITLE,
							"horizontal_align" : "center",
							"text_horizontal_align" : "center",
							"x" : 0,
							"y" : 3,
						},
					),
				},
				{
					"name" : "AttachMetinArrow",
					"tip" : "image",
					"x" : 0,
					"y" : -33,
					"horizontal_align" : "center",
					"vertical_align" : "center",
					"image" : "d:/ymir work/ui/game/windows/attach_metin_arrow.sub",
				},
				{
					"name" : "MetinSlot",
					"tip" : "image",
					"x" : 0,
					"y" : 5,
					"horizontal_align" : "center",
					"vertical_align" : "center",
					"image" : "d:/ymir work/ui/game/windows/metin_slot_silver.sub",

					"children" :
					(
						{
							"name" : "MetinImage",
							"tip" : "image",
							"x" : 1,
							"y" : 1,
							"horizontal_align" : "center",
							"image" : "d:/ymir work/ui/game/windows/metin_slot_silver.sub",
						},
					),
				},
				{
					"name" : "Question",
					"tip" : "text",
					"text" : uiScriptLocale.ATTACH_METIN_INFO,
					"horizontal_align" : "center",
					"vertical_align" : "bottom",
					"text_horizontal_align" : "center",
					"x" : 0,
					"y" : 54,
				},
				{
					"name" : "AcceptButton",
					"tip" : "button",

					"x" : -35,
					"y" : 35,

					"text" : uiScriptLocale.YES,
					"horizontal_align" : "center",
					"vertical_align" : "bottom",

					"default_image" : "d:/ymir work/ui/public/Middle_Button_01.sub",
					"over_image" : "d:/ymir work/ui/public/Middle_Button_02.sub",
					"down_image" : "d:/ymir work/ui/public/Middle_Button_03.sub",
				},
				{
					"name" : "CancelButton",
					"tip" : "button",

					"x" : 35,
					"y" : 35,

					"text" : uiScriptLocale.NO,
					"horizontal_align" : "center",
					"vertical_align" : "bottom",

					"default_image" : "d:/ymir work/ui/public/Middle_Button_01.sub",
					"over_image" : "d:/ymir work/ui/public/Middle_Button_02.sub",
					"down_image" : "d:/ymir work/ui/public/Middle_Button_03.sub",
				},
			),
		},
	),
}