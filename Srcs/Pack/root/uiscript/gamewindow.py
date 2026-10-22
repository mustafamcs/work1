import uiScriptLocale

window = {
	"name" : "GameWindow",
	"style" : ("not_pick",),

	"x" : 0,
	"y" : 0,

	"width" : SCREEN_WIDTH,
	"height" : SCREEN_HEIGHT,

	"children" :
	(
		{
			"name":"HelpButton",
			"tip":"button",
			"x" : 50,
			"y" : SCREEN_HEIGHT-170,
			"default_image" : "d:/ymir work/ui/game/windows/btn_bigplus_up.sub",
			"over_image" : "d:/ymir work/ui/game/windows/btn_bigplus_over.sub",
			"down_image" : "d:/ymir work/ui/game/windows/btn_bigplus_down.sub",

			"children" :
			(
				{
					"name":"HelpButtonLabel",
					"tip":"text",
					"x": 16,
					"y": 40,
					"text":uiScriptLocale.GAME_HELP,
					"r":1.0, "g":1.0, "b":1.0, "a":1.0,
					"text_horizontal_align":"center"
				},
			),
		},
		{
			"name":"QuestButton",
			"tip":"button",
			"x" : SCREEN_WIDTH-50-32,
			"y" : SCREEN_HEIGHT-170,
			"default_image" : "d:/ymir work/ui/game/windows/btn_bigplus_up.sub",
			"over_image" : "d:/ymir work/ui/game/windows/btn_bigplus_over.sub",
			"down_image" : "d:/ymir work/ui/game/windows/btn_bigplus_down.sub",

			"children" :
			(
				{
					"name":"QuestButtonLabel",
					"tip":"text",
					"x": 16,
					"y": 40,
					"text":uiScriptLocale.GAME_QUEST,
					"r":1.0, "g":1.0, "b":1.0, "a":1.0,
					"text_horizontal_align":"center"
				},
			),
		},
		{
			"name":"StatusPlusButton",
			"tip" : "button",
			"x" : 68,
			"y" : SCREEN_HEIGHT-100,
			"default_image" : "d:/ymir work/ui/game/windows/btn_bigplus_up.sub",
			"over_image" : "d:/ymir work/ui/game/windows/btn_bigplus_over.sub",
			"down_image" : "d:/ymir work/ui/game/windows/btn_bigplus_down.sub",

			"children" :
			(
				{
					"name":"StatusPlusLabel",
					"tip":"text",
					"x": 16,
					"y": 40,
					"text":uiScriptLocale.GAME_STAT_UP,
					"r":1.0, "g":1.0, "b":1.0, "a":1.0,
					"text_horizontal_align":"center"
				},
			),
		},
		{
			"name":"SkillPlusButton",
			"tip" : "button",
			"x" : SCREEN_WIDTH-50-32,
			"y" : SCREEN_HEIGHT-100,
			"default_image" : "d:/ymir work/ui/game/windows/btn_bigplus_up.sub",
			"over_image" : "d:/ymir work/ui/game/windows/btn_bigplus_over.sub",
			"down_image" : "d:/ymir work/ui/game/windows/btn_bigplus_down.sub",

			"children" :
			(
				{
					"name":"SkillPlusLabel",
					"tip":"text",
					"x": 16,
					"y": 40,
					"text":uiScriptLocale.GAME_SKILL_UP,
					"r":1.0, "g":1.0, "b":1.0, "a":1.0,
					"text_horizontal_align":"center"
				},
			),
		},
		{
			"name":"ExitObserver",
			"tip" : "button",
			"x" : SCREEN_WIDTH-50-32,
			"y" : SCREEN_HEIGHT-170,
			"default_image" : "d:/ymir work/ui/game/windows/btn_bigplus_up.sub",
			"over_image" : "d:/ymir work/ui/game/windows/btn_bigplus_over.sub",
			"down_image" : "d:/ymir work/ui/game/windows/btn_bigplus_down.sub",

			"children" :
			(
				{
					"name":"ExitObserverButtonName",
					"tip":"text",
					"x": 16,
					"y": 40,
					"text": uiScriptLocale.GAME_EXIT_OBSERVER,
					"r":1.0, "g":1.0, "b":1.0, "a":1.0,
					"text_horizontal_align":"center"
				},
			),
		},
		{
			"name":"BuildGuildBuilding",
			"tip" : "button",
			"x" : SCREEN_WIDTH-50-32,
			"y" : SCREEN_HEIGHT-170,
			"default_image" : "d:/ymir work/ui/game/windows/btn_bigplus_up.sub",
			"over_image" : "d:/ymir work/ui/game/windows/btn_bigplus_over.sub",
			"down_image" : "d:/ymir work/ui/game/windows/btn_bigplus_down.sub",

			"children" :
			(
				{
					"name":"BuildGuildBuildingButtonName",
					"tip":"text",
					"x": 16,
					"y": 40,
					"text": uiScriptLocale.GUILD_BUILDING_TITLE,
					"r":1.0, "g":1.0, "b":1.0, "a":1.0,
					"text_horizontal_align":"center"
				},
			),
		},
	),
}
