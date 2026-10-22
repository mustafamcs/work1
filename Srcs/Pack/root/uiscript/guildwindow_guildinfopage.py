import uiScriptLocale

SMALL_VALUE_FILE = "d:/ymir work/ui/public/Parameter_Slot_01.sub"
LARGE_VALUE_FILE = "d:/ymir work/ui/public/Parameter_Slot_03.sub"
XLARGE_VALUE_FILE = "d:/ymir work/ui/public/Parameter_Slot_04.sub"

window = {
	"name" : "GuildWindow_GuildInfoPage",

	"x" : 8,
	"y" : 30,

	"width" : 360,
	"height" : 298,

	"children" :
	(

		## Guild Info Title
		{
			"name":"Guild_Info_Title_Bar", "tip":"horizontalbar", "x":5, "y":10, "width":167,
			"children" :
			(
				{ "name":"Guild_Info_Point_Value", "tip":"text", "x":8, "y":3, "text":uiScriptLocale.GUILD_INFO, },

				## GuildName
				{
					"name" : "GuildName", "tip" : "text", "x" : 3, "y" : 31, "text" : uiScriptLocale.GUILD_INFO_NAME,
					"children" :
					(
						{
							"name" : "GuildNameSlot",
							"tip" : "image",
							"x" : 70,
							"y" : -2,
							"image" : LARGE_VALUE_FILE,
							"children" :
							(
								{"name" : "GuildNameValue", "tip":"text", "text":uiScriptLocale.GUILD_INFO_NAME_VALUE, "x":0, "y":0, "all_align":"center"},
							),
						},
					),
				},

				## GuildMaster
				{
					"name" : "GuildMaster", "tip" : "text", "x" : 3, "y" : 57, "text" : uiScriptLocale.GUILD_INFO_MASTER,
					"children" :
					(
						{
							"name" : "GuildMasterNameSlot",
							"tip" : "image",
							"x" : 70,
							"y" : -2,
							"image" : LARGE_VALUE_FILE,
							"children" :
							(
								{"name" : "GuildMasterNameValue", "tip":"text", "text":uiScriptLocale.GUILD_INFO_MASTER_VALUE, "x":0, "y":0, "all_align":"center"},
							),
						},
					),
				},

				## GuildLevel
				{
					"name" : "GuildLevel", "tip" : "text", "x" : 3, "y" : 93, "text" : uiScriptLocale.GUILD_INFO_LEVEL,
					"children" :
					(
						{
							"name" : "GuildLevelSlot",
							"tip" : "slotbar",
							"x" : 70,
							"y" : -2,
							"width" : 45,
							"height" : 17,
							"children" :
							(
								{"name" : "GuildLevelValue", "tip":"text", "text":"30", "x":0, "y":0, "all_align":"center"},
							),
						},
					),
				},

				## CurrentExperience
				{
					"name" : "CurrentExperience", "tip" : "text", "x" : 3, "y" : 119, "text" : uiScriptLocale.GUILD_INFO_CUR_EXP,
					"children" :
					(
						{
							"name" : "CurrentExperienceSlot",
							"tip" : "image",
							"x" : 70,
							"y" : -2,
							"image" : LARGE_VALUE_FILE,
							"children" :
							(
								{"name" : "CurrentExperienceValue", "tip":"text", "text":"10000000", "x":0, "y":0, "all_align":"center"},
							),
						},
					),
				},

				## LastExperience
				{
					"name" : "LastExperience", "tip" : "text", "x" : 3, "y" : 145, "text" : uiScriptLocale.GUILD_INFO_REST_EXP,
					"children" :
					(
						{
							"name" : "LastExperienceSlot",
							"tip" : "image",
							"x" : 70,
							"y" : -2,
							"image" : LARGE_VALUE_FILE,
							"children" :
							(
								{"name" : "LastExperienceValue", "tip":"text", "text":"123123123123", "x":0, "y":0, "all_align":"center"},
							),
						},
					),
				},

				## GuildMemberCount
				{
					"name" : "GuildMemberCount", "tip" : "text", "x" : 3, "y" : 171, "text" : uiScriptLocale.GUILD_INFO_MEMBER_NUM,
					"children" :
					(
						{
							"name" : "GuildMemberCountSlot",
							"tip" : "image",
							"x" : 70,
							"y" : -2,
							"image" : LARGE_VALUE_FILE,
							"children" :
							(
								{"name" : "GuildMemberCountValue", "tip":"text", "text":"30 / 32", "x":0, "y":0, "all_align":"center"},
							),
						},
					),
				},

				## GuildMemberLevelAverage
				{
					"name" : "GuildMemberLevelAverage", "tip" : "text", "x" : 3, "y" : 197, "text" : uiScriptLocale.GUILD_INFO_MEMBER_AVG_LEVEL,
					"children" :
					(
						{
							"name" : "GuildMemberLevelAverageSlot",
							"tip" : "image",
							"x" : 108,
							"y" : -2,
							"image" : SMALL_VALUE_FILE,
							"children" :
							(
								{"name" : "GuildMemberLevelAverageValue", "tip":"text", "text":"53", "x":0, "y":0, "all_align":"center"},
							),
						},
					),
				},

			),
		},

		## Button
		{
			"name" : "OfferButton",
			"tip" : "button",
			"x" : 127,
			"y" : 100,
			"text" : uiScriptLocale.GUILD_INFO_OFFER_EXP,
			"default_image" : "d:/ymir work/ui/public/small_button_01.sub",
			"over_image" : "d:/ymir work/ui/public/small_button_02.sub",
			"down_image" : "d:/ymir work/ui/public/small_button_03.sub",
		},

		###############################################################################################################

		## Guild Mark Title
		{
			"name":"Guild_Mark_Title_Bar", "tip":"horizontalbar", "x":188, "y":10, "width":167,
			"children" :
			(

				{ "name":"Guild_Mark_Title", "tip":"text", "x":8, "y":3, "text":uiScriptLocale.GUILD_MARK, },

				## LargeGuildMark
				{
					"name" : "LargeGuildMarkSlot",
					"tip" : "slotbar",
					"x" : 5,
					"y" : 24,
					"width" : 48+1,
					"height" : 36+1,
					"children" :
					(
						{
							"name" : "LargeGuildMark",
							"tip" : "mark",
							"x" : 1,
							"y" : 1,
						},
					),
				},

			),
		},

		## UploadButton
		{
			"name" : "UploadGuildMarkButton",
			"tip" : "button",
			"x" : 260,
			"y" : 33,
			"text" : uiScriptLocale.GUILD_INFO_UPLOAD_MARK,
			"default_image" : "d:/ymir work/ui/public/large_button_01.sub",
			"over_image" : "d:/ymir work/ui/public/large_button_02.sub",
			"down_image" : "d:/ymir work/ui/public/large_button_03.sub",
		},
		{
			"name" : "UploadGuildSymbolButton",
			"tip" : "button",
			"x" : 260,
			"y" : 33 + 23,
			"text" : uiScriptLocale.GUILD_INFO_UPLOAD_SYMBOL,
			"default_image" : "d:/ymir work/ui/public/large_button_01.sub",
			"over_image" : "d:/ymir work/ui/public/large_button_02.sub",
			"down_image" : "d:/ymir work/ui/public/large_button_03.sub",
		},

		## Guild Mark Title
		{
			"name":"Guild_Mark_Title_Bar", "tip":"horizontalbar", "x":188, "y":85, "width":167,
			"children" :
			(

				{ "name":"Guild_Mark_Title", "tip":"text", "x":8, "y":3, "text":uiScriptLocale.GUILD_INFO_ENEMY_GUILD, },

				{
					"name" : "EnemyGuildSlot1",
					"tip" : "image",
					"x" : 4,
					"y" : 27 + 26*0,
					"image" : XLARGE_VALUE_FILE,
					"children" :
					(
						{"name" : "EnemyGuildName1", "tip":"text", "text":uiScriptLocale.GUILD_INFO_ENEMY_GUILD_EMPTY, "x":0, "y":0, "all_align":"center"},
					),
				},
				{
					"name" : "EnemyGuildSlot2",
					"tip" : "image",
					"x" : 4,
					"y" : 27 + 26*1,
					"image" : XLARGE_VALUE_FILE,
					"children" :
					(
						{"name" : "EnemyGuildName2", "tip":"text", "text":uiScriptLocale.GUILD_INFO_ENEMY_GUILD_EMPTY, "x":0, "y":0, "all_align":"center"},
					),
				},
				{
					"name" : "EnemyGuildSlot3",
					"tip" : "image",
					"x" : 4,
					"y" : 27 + 26*2,
					"image" : XLARGE_VALUE_FILE,
					"children" :
					(
						{"name" : "EnemyGuildName3", "tip":"text", "text":uiScriptLocale.GUILD_INFO_ENEMY_GUILD_EMPTY, "x":0, "y":0, "all_align":"center"},
					),
				},
				{
					"name" : "EnemyGuildSlot4",
					"tip" : "image",
					"x" : 4,
					"y" : 27 + 26*3,
					"image" : XLARGE_VALUE_FILE,
					"children" :
					(
						{"name" : "EnemyGuildName4", "tip":"text", "text":uiScriptLocale.GUILD_INFO_ENEMY_GUILD_EMPTY, "x":0, "y":0, "all_align":"center"},
					),
				},
				{
					"name" : "EnemyGuildSlot5",
					"tip" : "image",
					"x" : 4,
					"y" : 27 + 26*4,
					"image" : XLARGE_VALUE_FILE,
					"children" :
					(
						{"name" : "EnemyGuildName5", "tip":"text", "text":uiScriptLocale.GUILD_INFO_ENEMY_GUILD_EMPTY, "x":0, "y":0, "all_align":"center"},
					),
				},
				{
					"name" : "EnemyGuildSlot6",
					"tip" : "image",
					"x" : 4,
					"y" : 27 + 26*5,
					"image" : XLARGE_VALUE_FILE,
					"children" :
					(
						{"name" : "EnemyGuildName6", "tip":"text", "text":uiScriptLocale.GUILD_INFO_ENEMY_GUILD_EMPTY, "x":0, "y":0, "all_align":"center"},
					),
				},

			),
		},

		## CancelButtons
		{
			"name" : "EnemyGuildCancel1",
			"tip" : "button",
			"x" : 310,
			"y" : 111 + 26*0,
			"text" : uiScriptLocale.CANCEL,
			"default_image" : "d:/ymir work/ui/public/small_button_01.sub",
			"over_image" : "d:/ymir work/ui/public/small_button_02.sub",
			"down_image" : "d:/ymir work/ui/public/small_button_03.sub",
		},
		{
			"name" : "EnemyGuildCancel2",
			"tip" : "button",
			"x" : 310,
			"y" : 111 + 26*1,
			"text" : uiScriptLocale.CANCEL,
			"default_image" : "d:/ymir work/ui/public/small_button_01.sub",
			"over_image" : "d:/ymir work/ui/public/small_button_02.sub",
			"down_image" : "d:/ymir work/ui/public/small_button_03.sub",
		},
		{
			"name" : "EnemyGuildCancel3",
			"tip" : "button",
			"x" : 310,
			"y" : 111 + 26*2,
			"text" : uiScriptLocale.CANCEL,
			"default_image" : "d:/ymir work/ui/public/small_button_01.sub",
			"over_image" : "d:/ymir work/ui/public/small_button_02.sub",
			"down_image" : "d:/ymir work/ui/public/small_button_03.sub",
		},
		{
			"name" : "EnemyGuildCancel4",
			"tip" : "button",
			"x" : 310,
			"y" : 111 + 26*3,
			"text" : uiScriptLocale.CANCEL,
			"default_image" : "d:/ymir work/ui/public/small_button_01.sub",
			"over_image" : "d:/ymir work/ui/public/small_button_02.sub",
			"down_image" : "d:/ymir work/ui/public/small_button_03.sub",
		},
		{
			"name" : "EnemyGuildCancel5",
			"tip" : "button",
			"x" : 310,
			"y" : 111 + 26*4,
			"text" : uiScriptLocale.CANCEL,
			"default_image" : "d:/ymir work/ui/public/small_button_01.sub",
			"over_image" : "d:/ymir work/ui/public/small_button_02.sub",
			"down_image" : "d:/ymir work/ui/public/small_button_03.sub",
		},
		{
			"name" : "EnemyGuildCancel6",
			"tip" : "button",
			"x" : 310,
			"y" : 111 + 26*5,
			"text" : uiScriptLocale.CANCEL,
			"default_image" : "d:/ymir work/ui/public/small_button_01.sub",
			"over_image" : "d:/ymir work/ui/public/small_button_02.sub",
			"down_image" : "d:/ymir work/ui/public/small_button_03.sub",
		},

		## DeclareWar
		{
			"name" : "DeclareWarButton",
			"tip" : "button",
			"x" : 250 + 15,
			"y" : 264,
			"text" : uiScriptLocale.GUILD_INFO_DECALRE_WAR,
			"default_image" : "d:/ymir work/ui/public/large_button_01.sub",
			"over_image" : "d:/ymir work/ui/public/large_button_02.sub",
			"down_image" : "d:/ymir work/ui/public/large_button_03.sub",
		},

	),
}
