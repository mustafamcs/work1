import uiScriptLocale

window = {
	"name" : "ChangePasswordDialog",

	"x" : 0,
	"y" : 0,

	"style" : ("movable", "float",),

	"width" : 220,
	"height" : 137,

	"children" :
	(
		{
			"name" : "board",
			"tip" : "board",

			"x" : 0,
			"y" : 0,

			"width" : 220,
			"height" : 137,

			"children" :
			(
				## Title
				{
					"name" : "titlebar",
					"tip" : "titlebar",
					"style" : ("attach",),

					"x" : 8,
					"y" : 8,

					"width" : 204,
					"color" : "gray",

					"children" :
					(
						{

							"name" : "TitleName",
							"tip" : "text",

							"x" : 0,
							"y" : 3,
							"horizontal_align" : "center",

							"text" : uiScriptLocale.CHANGE_PASSWORD_TITLE,
							"text_horizontal_align":"center"
						},
					),
				},

				## Password Slot
				{
					"name" : "old_password_slot",
					"tip" : "image",

					"x" : 135,
					"y" : 34,

					"image" : "d:/ymir work/ui/public/Parameter_Slot_02.sub",

					"children" :
					(
						{
							"name" : "old_password_name",
							"tip" : "text",

							"x" : -110,
							"y" : 3,
							"text" : uiScriptLocale.CHANGE_PASSWORD_OLD,
						},
						{
							"name" : "old_password_value",
							"tip" : "editline",

							"x" : 3,
							"y" : 3,

							"width" : 60,
							"height" : 18,

							"input_limit" : 6,
							"secret_flag" : 1,
						},
					),
				},
				{
					"name" : "new_password_slot",
					"tip" : "image",

					"x" : 135,
					"y" : 59,

					"image" : "d:/ymir work/ui/public/Parameter_Slot_02.sub",

					"children" :
					(
						{
							"name" : "new_password_name",
							"tip" : "text",

							"x" : -110,
							"y" : 3,
							"text" : uiScriptLocale.CHANGE_PASSWORD_NEW,
						},
						{
							"name" : "new_password_value",
							"tip" : "editline",

							"x" : 3,
							"y" : 3,

							"width" : 60,
							"height" : 18,

							"input_limit" : 6,
							"secret_flag" : 1,
						},
					),
				},
				{
					"name" : "new_password_check_slot",
					"tip" : "image",

					"x" : 135,
					"y" : 79,

					"image" : "d:/ymir work/ui/public/Parameter_Slot_02.sub",

					"children" :
					(
						{
							"name" : "new_password_check_name",
							"tip" : "text",

							"x" : -110,
							"y" : 3,
							"text" : uiScriptLocale.CHANGE_PASSWORD_CONFIRM,
						},
						{
							"name" : "new_password_check_value",
							"tip" : "editline",

							"x" : 3,
							"y" : 3,

							"width" : 60,
							"height" : 18,

							"input_limit" : 6,
							"secret_flag" : 1,
						},
					),
				},

				## Button
				{
					"name" : "accept_button",
					"tip" : "button",

					"x" : -35,
					"y" : 103,

					"text" : uiScriptLocale.OK,
					"horizontal_align" : "center",

					"default_image" : "d:/ymir work/ui/public/middle_button_01.sub",
					"over_image" : "d:/ymir work/ui/public/middle_button_02.sub",
					"down_image" : "d:/ymir work/ui/public/middle_button_03.sub",
				},
				{
					"name" : "cancel_button",
					"tip" : "button",

					"x" : 35,
					"y" : 103,
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