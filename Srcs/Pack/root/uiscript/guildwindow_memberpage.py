import uiScriptLocale

window = {
	"name" : "GuildWindow_MemberPage",

	"x" : 8,
	"y" : 30,

	"width" : 360,
	"height" : 298,

	"children" :
	(
		## ScrollBar
		{
			"name" : "ScrollBar",
			"tip" : "scrollbar",

			"x" : 341,
			"y" : 20,
			"scrollbar_tip" : "normal",
			"size" : 270,
		},

		## Grade
		{
			"name" : "IndexName", "tip" : "text", "x" : 43, "y" : 8, "text" : uiScriptLocale.GUILD_MEMBER_NAME,
		},
		{
			"name" : "IndexGrade", "tip" : "text", "x" : 119, "y" : 8, "text" : uiScriptLocale.GUILD_MEMBER_RANK,
		},
		{
			"name" : "IndexJob", "tip" : "text", "x" : 177, "y" : 8, "text" : uiScriptLocale.GUILD_MEMBER_JOB,
		},
		{
			"name" : "IndexLevel", "tip" : "text", "x" : 217, "y" : 8, "text" : uiScriptLocale.GUILD_MEMBER_LEVEL,
		},
		{
			"name" : "IndexOffer", "tip" : "text", "x" : 251, "y" : 8, "text" : uiScriptLocale.GUILD_MEMBER_SPECIFIC_GRAVITY,
		},
		{
			"name" : "IndexGeneral", "tip" : "text", "x" : 304, "y" : 8, "text" : uiScriptLocale.GUILD_MEMBER_KNIGHT,
		},

	),
}
