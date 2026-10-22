import uiScriptLocale

window = {
	"name" : "ChangeGradeNameDialog",

	"x" : 0,
	"y" : 0,

	"style" : ("movable", "float",),

	"width" : 170,
	"height" : 90,

	"children" :
	(
		{
			"name" : "Board",
			"tip" : "board_with_titlebar",

			"x" : 0,
			"y" : 0,

			"width" : 170,
			"height" : 90,

			"title" : uiScriptLocale.GUILD_GRADE_CHANGE_GRADE_NAME,

			"children" :
			(

				## GradeName Slot
				{
					"name" : "GradeNameSlot",
					"tip" : "image",

					"x" : 0,
					"y" : 34,
					"horizontal_align" : "center",

					"image" : "d:/ymir work/ui/public/Parameter_Slot_02.sub",

					"children" :
					(
						{
							"name" : "GradeNameValue",
							"tip" : "editline",

							"x" : 3,
							"y" : 3,

							"width" : 60,
							"height" : 18,

							"input_limit" : 8,
						},
					),
				},

				## Button
				{
					"name" : "AcceptButton",
					"tip" : "button",

					"x" : 170/2 - 61 - 5,
					"y" : 58,

					"text" : uiScriptLocale.OK,

					"default_image" : "d:/ymir work/ui/public/middle_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/middle_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/middle_button_03.sub",
				},
				{
					"name" : "CancelButton",
					"tip" : "button",

					"x" : 170/2 + 5,
					"y" : 58,

					"text" : uiScriptLocale.CANCEL,

					"default_image" : "d:/ymir work/ui/public/middle_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/middle_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/middle_button_03.sub",
				},
			),
		},
	),
}