import uiScriptLocale

ROOT_PATH = "d:/ymir work/ui/public/"
SMALL_VALUE_FILE = "d:/ymir work/ui/public/Parameter_Slot_02.sub"
MIDDLE_VALUE_FILE = "d:/ymir work/ui/public/Parameter_Slot_03.sub"

TEMP_X = 110

window = {
	"name" : "BuildGuildBuildingWindow",
	"style" : ("movable", "float",),

	"x" : 10,
	"y" : SCREEN_HEIGHT - 240 - 50,

	"width" : 355+TEMP_X,
	"height" : 240,

	"children" :
	(

		{
			"name" : "Board",
			"tip" : "board_with_titlebar",

			"x" : 0,
			"y" : 0,

			"width" : 355+TEMP_X,
			"height" : 240,

			"title" : uiScriptLocale.GUILD_BUILDING_TITLE,

			"children" :
			(

				{
					"name" : "BuildingCategoryTitle",
					"tip" : "text",

					"x" : 15 + 50,
					"y" : 33,
					"text_horizontal_align" : "center",

					"text" : uiScriptLocale.GUILD_BUILDING_CATEGORY_TITLE,
				},
				{
					"name" : "BuildingCategoryBar",
					"tip" : "slotbar",

					"x" : 15,
					"y" : 50,

					"width" : 100,
					"height" : 80,

					"children" :
					(
						{
							"name" : "CategoryList",
							"tip" : "listbox",

							"x" : 0,
							"y" : 1,

							"width" : 100,
							"height" : 80,
						},
					),
				},

				{
					"name" : "BuildingPriceTitle",
					"tip" : "text", "x" : 30, "y" : 143, "text" : uiScriptLocale.GUILD_BUILDING_PRICE,
					"text_horizontal_align" : "center",
					"children" :
					(
						{
							"name":"BuildingPriceSlot",
							"tip":"slotbar", "x":25, "y":-4, "width":60, "height":17,
							"children" :
							(
								{ "name" : "BuildingPriceValue", "tip" : "text", "x" : 0, "y" : 1, "all_align" : "center", "text" : "50000000", },
							),
						},
					),
				},

				{
					"name" : "BuildingMaterialStoneTitle",
					"tip" : "text", "x" : 30, "y" : 163, "text" : uiScriptLocale.GUILD_BUILDING_STONE,
					"text_horizontal_align" : "center",
					"children" :
					(
						{
							"name":"BuildingMaterialStoneSlot",
							"tip":"slotbar", "x":25, "y":-4, "width":60, "height":17,
							"children" :
							(
								{ "name" : "BuildingMaterialStoneValue", "tip" : "text", "x" : 0, "y" : 1, "all_align" : "center", "text" : "50000000", },
							),
						},
					),
				},

				{
					"name" : "BuildingMaterialLogTitle",
					"tip" : "text", "x" : 30, "y" : 183, "text" : uiScriptLocale.GUILD_BUILDING_LOG,
					"text_horizontal_align" : "center",
					"children" :
					(
						{
							"name":"BuildingMaterialLogSlot",
							"tip":"slotbar", "x":25, "y":-4, "width":60, "height":17,
							"children" :
							(
								{ "name" : "BuildingMaterialLogValue", "tip" : "text", "x" : 0, "y" : 1, "all_align" : "center", "text" : "50000000", },
							),
						},
					),
				},

				{
					"name" : "BuildingMaterialPlywoodTitle",
					"tip" : "text", "x" : 30, "y" : 203, "text" : uiScriptLocale.GUILD_BUILDING_PLY,
					"text_horizontal_align" : "center",
					"children" :
					(
						{
							"name":"BuildingMaterialPlywoodSlot",
							"tip":"slotbar", "x":25, "y":-4, "width":60, "height":17,
							"children" :
							(
								{ "name" : "BuildingMaterialPlywoodValue", "tip" : "text", "x" : 0, "y" : 1, "all_align" : "center", "text" : "50000000", },
							),
						},
					),
				},

				{
					"name" : "temp_window",
					"tip" : "window",
					"style" : ("not_pick",),

					"x" : TEMP_X,
					"y" : 0,
					"width" : 355,
					"height" : 240,

					"children" :
					(

						### START_TEMP
						{
							"name" : "BuildingListTitle",
							"tip" : "text",

							"x" : 15 + 60,
							"y" : 33,
							"text_horizontal_align" : "center",

							"text" : uiScriptLocale.GUILD_BUILDING_LIST_TITLE,
						},

						{
							"name" : "BuildingListBar",
							"tip" : "slotbar",

							"x" : 15,
							"y" : 50,

							"width" : 120,
							"height" : 172,

							"children" :
							(
								{
									"name" : "BuildingList",
									"tip" : "listbox",

									"x" : 0,
									"y" : 1,

									"width" : 105,
									"height" : 172,
								},
								{
									"name" : "ListScrollBar",
									"tip" : "scrollbar",

									"x" : 15,
									"y" : 2,
									"size" : 172-2,
									"horizontal_align" : "right",
								},
							),
						},

						{
							"name" : "BuildingPositionTitle",
							"tip" : "text",

							"x" : 250,
							"y" : 33,
							"text_horizontal_align" : "center",

							"text" : uiScriptLocale.GUILD_BUILDING_POSITION,
						},
						{
							"name" : "PositionButton",
							"tip" : "radio_button", "x" : 280, "y" : 50, "text" : uiScriptLocale.GUILD_BUILDING_CHANGE,
							"default_image" : ROOT_PATH + "Big_Button_01.sub",
							"over_image" : ROOT_PATH + "Big_Button_02.sub",
							"down_image" : ROOT_PATH + "Big_Button_03.sub",
						},
						{
							"name" : "BuildingPositionXTitle",
							"tip" : "text", "x" : 150, "y" : 53, "text" : "X",
							"text_horizontal_align" : "center",
							"children" :
							(
								{
									"name":"BuildingPositionXSlot",
									"tip":"image", "x":23, "y":-3, "image":MIDDLE_VALUE_FILE,
									"children" :
									(
										{ "name" : "BuildingPositionXValue", "tip" : "text", "x" : 0, "y" : 0, "all_align" : "center", "text" : "999", },
									),
								},
							),
						},
						{
							"name" : "BuildingPositionY",
							"tip" : "text", "x" : 150, "y" : 73, "text" : "Y",
							"text_horizontal_align" : "center",
							"children" :
							(
								{
									"name":"BuildingPositionYSlot",
									"tip":"image", "x":23, "y":-3, "image":MIDDLE_VALUE_FILE,
									"children" :
									(
										{ "name" : "BuildingPositionYValue", "tip" : "text", "x" : 0, "y" : 0, "all_align" : "center", "text" : "999", },
									),
								},
							),
						},

						{
							"name" : "BuildingRotationTitle",
							"tip" : "text",

							"x" : 250,
							"y" : 95,
							"text_horizontal_align" : "center",

							"text" : uiScriptLocale.GUILD_BUILDING_DIRECTION,
						},
						{
							"name" : "BuildingRotationXTitle",
							"tip" : "text", "x" : 150, "y" : 115, "text" : "X",
							"text_horizontal_align" : "center",
						},
						{
							"name" : "BuildingRotationX",
							"tip" : "sliderbar",
							"x" : 158, "y" : 115,
						},
						{
							"name" : "BuildingRotationYTitle",
							"tip" : "text", "x" : 150, "y" : 135, "text" : "Y",
							"text_horizontal_align" : "center",
						},
						{
							"name" : "BuildingRotationY",
							"tip" : "sliderbar",
							"x" : 158, "y" : 135,
						},
						{
							"name" : "BuildingRotationZTitle",
							"tip" : "text", "x" : 150, "y" : 155, "text" : "Z",
							"text_horizontal_align" : "center",
						},
						{
							"name" : "BuildingRotationZ",
							"tip" : "sliderbar",
							"x" : 158, "y" : 155,
						},

						{
							"name" : "PreviewButton",
							"tip" : "toggle_button",

							"x" : 200,
							"y" : 60,
							"vertical_align" : "bottom",

							"text" : uiScriptLocale.GUILD_BUILDING_PREVIEW,

							"default_image" : ROOT_PATH + "Large_Button_01.sub",
							"over_image" : ROOT_PATH + "Large_Button_02.sub",
							"down_image" : ROOT_PATH + "Large_Button_03.sub",
						},

						{
							"name" : "AcceptButton",
							"tip" : "button",

							"x" : 200,
							"y" : 35,

							"text" : uiScriptLocale.ACCEPT,
							"vertical_align" : "bottom",

							"default_image" : ROOT_PATH + "Small_Button_01.sub",
							"over_image" : ROOT_PATH + "Small_Button_02.sub",
							"down_image" : ROOT_PATH + "Small_Button_03.sub",
						},
						{
							"name" : "CancelButton",
							"tip" : "button",

							"x" : 245,
							"y" : 35,

							"text" : uiScriptLocale.CANCEL,
							"vertical_align" : "bottom",

							"default_image" : ROOT_PATH + "Small_Button_01.sub",
							"over_image" : ROOT_PATH + "Small_Button_02.sub",
							"down_image" : ROOT_PATH + "Small_Button_03.sub",
						},
						### END_TEMP

					),

				},

			),
		},

	),
}
