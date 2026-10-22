import uiScriptLocale

ADD_HEIGHT = 17
LOCALE_PATH = uiScriptLocale.WINDOWS_PATH

window = {
	"name" : "GuildWindow_GuildSkillPage",

	"x" : 8,
	"y" : 30,

	"width" : 360,
	"height" : 298,

	"children" :
	(

		## PassiveSkill
		{
			"name":"Passive_Skill_Bar",
			"tip":"horizontalbar",
			"x":0,
			"y":3 + ADD_HEIGHT,
			"width":320,
			"horizontal_align" : "center",
			"children" :
			(

				{
					"name":"Passive_Skill_Title",
					"tip":"text",
					"x" : 7,
					"y" : 2,
					"vertical_align" : "center",
					"text_vertical_align" : "center",
					"text" : uiScriptLocale.GUILD_SKILL_PASSIVE,
				},
				{
					"name":"Passive_Skill_Plus_Label",
					"tip":"image",
					"x":240,
					"y":2,
					"image":LOCALE_PATH+"label_uppt.sub",
					"children" :
					(
						{
							"name":"Skill_Plus_Value",
							"tip":"text",
							"x":61,
							"y":0,
							"text":"99",
							"text_horizontal_align":"center"
						},
					),
				},

			),
		}, ## end of PassiveSkill's horizontal bar

		{
			"name" : "Passive_Skill_Slot_Table",
			"tip" : "grid_table",

			"x" : 20 + 16,
			"y" : 6 + 23 + ADD_HEIGHT,

			"start_index" : 200,
			"x_count" : 9,
			"y_count" : 1,
			"x_step" : 32,
			"y_step" : 32,

			"image" : "d:/ymir work/ui/public/Slot_Base.sub"
		},

		## ActiveSkill
		{
			"name":"Active_Skill_Bar",
			"tip":"horizontalbar",
			"x":0,
			"y":70 + ADD_HEIGHT,
			"width":320,
			"horizontal_align" : "center",
			"children" :
			(

				{
					"name":"Active_Skill_Title",
					"tip":"text",
					"x" : 7,
					"y" : 2,
					"vertical_align" : "center",
					"text_vertical_align" : "center",
					"text" : uiScriptLocale.GUILD_SKILL_ACTIVE,
				},

			),
		}, ## end of PassiveSkill's horizontal bar

		{
			"name" : "Active_Skill_Slot_Table",
			"tip" : "grid_table",

			"x" : 20 + 16,
			"y" : 73 + 23 + ADD_HEIGHT,

			"start_index" : 210,
			"x_count" : 9,
			"y_count" : 1,
			"x_step" : 32,
			"y_step" : 32,

			"image" : "d:/ymir work/ui/public/Slot_Base.sub"
		},

		## Affect
		{
			"name":"Affect_Bar",
			"tip":"horizontalbar",
			"x":0,
			"y":137 + ADD_HEIGHT,
			"width":320,
			"horizontal_align" : "center",
			"children" :
			(

				{
					"name":"Affect_Title",
					"tip":"text",
					"x" : 0,
					"y" : 0,
					"all_align" : "center",
					"text" : uiScriptLocale.GUILD_SKILL_STATE,
				},

			),
		}, ## end of AffectedSkill's horizontal bar

		{
			"name" : "Affect_Slot_Table",
			"tip" : "grid_table",

			"x" : 20 + 16,
			"y" : 137 + 30 + ADD_HEIGHT,

			"start_index" : 0,
			"x_count" : 9,
			"y_count" : 2,
			"x_step" : 32,
			"y_step" : 32,

			"image" : "d:/ymir work/ui/public/Slot_Base.sub"
		},

		###########################################################################################

		{
			"name":"Dragon_God_Power_Title",
			"tip":"text",
			"x" : 20,
			"y" : 243 + ADD_HEIGHT + 5,
			"text" : uiScriptLocale.GUILD_SKILL_POWER,
		},
		{
			"name":"Dragon_God_Power_Gauge_Slot",
			"tip":"image",
			"x" : 65,
			"y" : 243 + ADD_HEIGHT + 5,
			"image" : "d:/ymir work/ui/game/guild/gauge.sub",
		},
		{
			"name" : "Dragon_God_Power_Gauge",
			"tip" : "ani_image",

			"x" : 69,
			"y" : 243 + ADD_HEIGHT + 5,

			"delay" : 6,

			"images" :
			(
				"D:/Ymir Work/UI/Pattern/SPGauge/01.tga",
				"D:/Ymir Work/UI/Pattern/SPGauge/02.tga",
				"D:/Ymir Work/UI/Pattern/SPGauge/03.tga",
				"D:/Ymir Work/UI/Pattern/SPGauge/04.tga",
				"D:/Ymir Work/UI/Pattern/SPGauge/05.tga",
				"D:/Ymir Work/UI/Pattern/SPGauge/06.tga",
				"D:/Ymir Work/UI/Pattern/SPGauge/07.tga",
			),
		},
		{
			"name" : "Dragon_God_Power_Slot",
			"tip" : "image",
			"x" : 255,
			"y" : 241 + ADD_HEIGHT - 4,
			"image" : "d:/ymir work/ui/public/Parameter_Slot_03.sub",
			"children" :
			(

				{
					"name":"Dragon_God_Power_Value",
					"tip":"text",
					"x" : 0,
					"y" : 0,
					"all_align" : "center",
					"text" : "3000 / 3000",
				},

			),
		},
		## OfferButton
		{
			"name" : "Heal_GSP_Button",
			"tip" : "button",
			"x" : 257,
			"y" : 241 + ADD_HEIGHT + 17,
			"text" : uiScriptLocale.GUILD_SKIlL_HEAL_GSP,
			"default_image" : "d:/ymir work/ui/public/large_button_01.sub",
			"over_image" : "d:/ymir work/ui/public/large_button_02.sub",
			"down_image" : "d:/ymir work/ui/public/large_button_03.sub",
		},

	),
}
