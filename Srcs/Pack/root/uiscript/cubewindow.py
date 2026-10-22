import localeInfo
import uiScriptLocale

LOCALE_PATH = uiScriptLocale.WINDOWS_PATH
ICON_SLOT_FILE = "d:/ymir work/ui/public/Slot_Base.sub"

window = {
	"name" : "CubeWindow",

#	"x" : 430,
#	"y" : 130,
	"x" : SCREEN_WIDTH - 176 - 200 - 80,
	"y" : SCREEN_HEIGHT - 37 - 563,


	"style" : ("movable", "float",),

	"width" : 285,
	"height" : 521,

	"children" :
	(
		{
			"name" : "board",
			"tip" : "expanded_image",
			"style" : ("attach",),

			"x" : 0,
			"y" : 0,

			"width"		: 285,
			"height"	: 521,

			"image"		: uiScriptLocale.LOCALE_UISCRIPT_PATH + "new_cube_bg.tga",

			"children" :
			(
				## Title
				{
					"name" : "TitleBar",
					"tip" : "titlebar",
					"style" : ("attach",),

					"x" : 5,
					"y" : 5,

					"width" : 273,
					"color" : "yellow",

					"children" :
					(
						{ "name":"TitleName", "tip":"text", "x":77, "y":3, "text":uiScriptLocale.CUBE_TITLE, "text_horizontal_align":"center" },
					),
				},

				## Cube Slot
				{
					"name" : "CubeSlot",
					"tip" : "grid_table",

					"x" : 14,
					"y" : 364,

					"start_index" : 0,
					"x_count" : 8,
					"y_count" : 3,
					"x_step" : 32,
					"y_step" : 32,

					"image" : "d:/ymir work/ui/public/Slot_Base.sub"
				},
				## Print
				{
					"name" : "NeedMoney",
					"tip" : "text",

					"x" : 20,
					"y" : 468,

					"width" : 200,

					"horizontal_align" : "right",
					"text_horizontal_align" : "right",

					"text" : localeInfo.NumberToMoneyString(0),
				},

				{
					"name" : "contentScrollbar",
					"tip" : "thin_scrollbar",

					"x" : 253,
					"y" : 38,

					"size" : 315,
				},

				# Cube Result List. 1 ~ 3
				{
					"name" : "result1board",
					"tip" : "window",

					"x" : 25,
					"y" : 41,

					"width" : 216,
					"height" : 64,

					"children" :
					(
						{
							"name" : "result1",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 0,
							"y" : 0,
						},
						{
							"name" : "material11",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 57,
							"y" : 0,
						},
						{
							"name" : "material12",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 90,
							"y" : 0,
						},
						{
							"name" : "material13",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 123,
							"y" : 0,
						},
						{
							"name" : "material14",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 156,
							"y" : 0,
						},
						{
							"name" : "material15",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 189,
							"y" : 0,
						},
					),

				},
				{
					"name" : "result2board",
					"tip" : "window",

					"x" : 25,
					"y" : 147,

					"width" : 216,
					"height" : 64,

					"children" :
					(
						{
							"name" : "result2",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 0,
							"y" : 0,
						},
						{
							"name" : "material21",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 57,
							"y" : 0,
						},
						{
							"name" : "material22",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 90,
							"y" : 0,
						},
						{
							"name" : "material23",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 123,
							"y" : 0,
						},
						{
							"name" : "material24",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 156,
							"y" : 0,
						},
						{
							"name" : "material25",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 189,
							"y" : 0,
						},
					),
				},
				{
					"name" : "result3board",
					"tip" : "window",

					"x" : 25,
					"y" : 253,

					"width" : 216,
					"height" : 64,

					"children" :
					(
						{
							"name" : "result3",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 0,
							"y" : 0,
						},
						{
							"name" : "material31",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 57,
							"y" : 0,
						},
						{
							"name" : "material32",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 90,
							"y" : 0,
						},
						{
							"name" : "material33",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 123,
							"y" : 0,
						},
						{
							"name" : "material34",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 156,
							"y" : 0,
						},
						{
							"name" : "material35",
							"tip" : "grid_table",
							"start_index" : 0,

							"x_count" : 1,
							"y_count" : 3,
							"x_step" : 32,
							"y_step" : 32,

							"x" : 189,
							"y" : 0,
						},
					),
				},


				## Button
				{
					"name" : "AcceptButton",
					"tip" : "button",

					"x" : 148,
					"y" : 32,
					"vertical_align" : "bottom",

					"text" : uiScriptLocale.OK,

					"default_image" : "d:/ymir work/ui/public/middle_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/middle_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/middle_button_03.sub",
				},
				{
					"name" : "CancelButton",
					"tip" : "button",

					"x" : 211,
					"y" : 32,
					"vertical_align" : "bottom",

					"text" : uiScriptLocale.CANCEL,

					"default_image" : "d:/ymir work/ui/public/middle_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/middle_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/middle_button_03.sub",
				},

			),
		},
	),
}
