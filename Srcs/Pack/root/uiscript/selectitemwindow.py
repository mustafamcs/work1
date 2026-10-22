import uiScriptLocale

window = {
	"name" : "SelectItemWindow",

	"x" : 100,
	"y" : 20,

	"style" : ("movable", "float",),

	"width" : 184,
	"height" : 332,

	"children" :
	(
		{
			"name" : "board",
			"tip" : "board",

			"x" : 0,
			"y" : 0,

			"width" : 184,
			"height" : 332,

			"children" :
			(
				## Title
				{
					"name" : "TitleBar",
					"tip" : "titlebar",
					"style" : ("attach",),

					"x" : 8,
					"y" : 7,

					"width" : 169,

					"children" :
					(
						{ "name":"TitleName", "tip":"text", "x":77, "y":3, "text":uiScriptLocale.SELECT_METIN_STONE_TITLE, "text_horizontal_align":"center" },
					),
				},

				## Item Slot
				{
					"name" : "ItemSlot",
					"tip" : "grid_table",

					"x" : 12,
					"y" : 34,

					"start_index" : 0,
					"x_count" : 5,
					"y_count" : 8,
					"x_step" : 32,
					"y_step" : 32,

					"image" : "d:/ymir work/ui/public/Slot_Base.sub",
				},

				## Button
				{
					"name" : "ExitButton",
					"tip" : "button",

					"x" : 0,
					"y" : 34,

					"text" : uiScriptLocale.CLOSE,
					"horizontal_align" : "center",
					"vertical_align" : "bottom",

					"default_image" : "d:/ymir work/ui/public/large_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/large_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/large_button_03.sub",
				},

			),
		},
	),
}
