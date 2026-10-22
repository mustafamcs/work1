import uiScriptLocale

window = {
	"name" : "RefineDialog",
	"style" : ("movable", "float",),

	"x" : SCREEN_WIDTH - 400,
	"y" : 70 * 800 / SCREEN_HEIGHT,

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
							"text" : uiScriptLocale.REFINE_TTILE,
							"horizontal_align" : "center",
							"text_horizontal_align" : "center",
							"x" : 0,
							"y" : 3,
						},
					),
				},
				{
					"name" : "SuccessPercentage",
					"tip" : "text",
					"text" : uiScriptLocale.REFINE_INFO,
					"horizontal_align" : "center",
					"vertical_align" : "bottom",
					"text_horizontal_align" : "center",
					"x" : 0,
					"y" : 70,
				},
				{
					"name" : "Cost",
					"tip" : "text",
					"text" : uiScriptLocale.REFINE_COST,
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

					"text" : uiScriptLocale.OK,
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

					"text" : uiScriptLocale.CANCEL,
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