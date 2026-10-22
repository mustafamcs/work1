import uiScriptLocale

TEMPORARY_HEIGHT = 16

window = {
	"name" : "InputDialog_WithDescription",

	"x" : 0,
	"y" : 0,

	"style" : ("movable", "float",),

	"width" : 170,
	"height" : 106 + TEMPORARY_HEIGHT,

	"children" :
	(
		{
			"name" : "Board",
			"tip" : "board_with_titlebar",

			"x" : 0,
			"y" : 0,

			"width" : 170,
			"height" : 106 + TEMPORARY_HEIGHT,

			"title" : "",

			"children" :
			(

				## Text
				{
					"name" : "Description1",
					"tip" : "text",
					"text" : "",
					"horizontal_align" : "center",
					"text_horizontal_align" : "center",
					"x" : 0,
					"y" : 34,
				},
				{
					"name" : "Description2",
					"tip" : "text",
					"text" : "",
					"horizontal_align" : "center",
					"text_horizontal_align" : "center",
					"x" : 0,
					"y" : 34 + TEMPORARY_HEIGHT,
				},

				## Input Slot
				{
					"name" : "InputSlot",
					"tip" : "slotbar",

					"x" : 0,
					"y" : 51 + TEMPORARY_HEIGHT,
					"width" : 90,
					"height" : 18,
					"horizontal_align" : "center",

					"children" :
					(
						{
							"name" : "InputValue",
							"tip" : "editline",

							"x" : 3,
							"y" : 3,

							"width" : 90,
							"height" : 18,

							"input_limit" : 12,
						},
					),
				},

				## Button
				{
					"name" : "AcceptButton",
					"tip" : "button",

					"x" : - 61 - 5 + 30,
					"y" : 74 + TEMPORARY_HEIGHT,
					"horizontal_align" : "center",

					"text" : uiScriptLocale.OK,

					"default_image" : "d:/ymir work/ui/public/middle_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/middle_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/middle_button_03.sub",
				},
				{
					"name" : "CancelButton",
					"tip" : "button",

					"x" : 5 + 30,
					"y" : 74 + TEMPORARY_HEIGHT,
					"horizontal_align" : "center",

					"text" : uiScriptLocale.CANCEL,

					"default_image" : "d:/ymir work/ui/public/middle_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/middle_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/middle_button_03.sub",
				},

			),
		},
	),
}