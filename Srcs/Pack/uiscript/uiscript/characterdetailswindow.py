import localeInfo
import uiScriptLocale

LOCALE_PATH = uiScriptLocale.WINDOWS_PATH

MAINBOARD_WIDTH = 200
MAINBOARD_HEIGHT = 364#361

LABEL_START_X = 0-10
LABEL_START_Y = 39
LABEL_WIDTH = 50
LABEL_HEIGHT = 17
LABEL_GAP = LABEL_HEIGHT+7
LABEL_NAME_POS_X = 0-10
TITLE_BAR_POS_X = 10
TITLE_BAR_WIDTH = 163

window = {
	"name" : "CharacterDetailsWindow",
	"style" : ("float",),
	
	"x" : 274, #24+253-3,
	"y" : (SCREEN_HEIGHT - 398) / 2,

	"width" : MAINBOARD_WIDTH,
	"height" : MAINBOARD_HEIGHT,
	
	"children" :
	(
		## MainBoard
		{
			"name" : "MainBoard",
			"tip" : "board",
			"style" : ("attach","ltr"),
			
			## CharacterWindow.py etkilenir
			"x" : 0,
			"y" : 0,

			"width" : MAINBOARD_WIDTH,
			"height" : MAINBOARD_HEIGHT,
			
			"children" :
			(
				## Başlık çubuğu
				{
					"name" : "TitleBar",
					"tip" : "titlebar",
					"style" : ("attach",),

					"x" : 6,
					"y" : 7,

					"width" : MAINBOARD_WIDTH - 13,
					
					"children" :
					(
						{ "name" : "TitleName", "tip" : "text", "x" : 0, "y" : 0, "text": localeInfo.DETAILS_TITLE, "all_align":"center" },
					),
				},
							
				## Kaydırma çubuğu
				{
					"name" : "ScrollBar",
					"tip" : "scrollbar",

					"x" : 24,
					"y" : 31,
					"size" : MAINBOARD_HEIGHT - 40,
					"horizontal_align" : "right",
				},
				
				## Yatay çubuk
				{ 
					"name" : "horizontalbar0", "tip":"horizontalbar", "x":TITLE_BAR_POS_X, "y":LABEL_START_Y+LABEL_GAP*0, "width":TITLE_BAR_WIDTH, 
					"children" : ( { "name" : "horizontalbarName0", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", }, ),
				},
				{ 
					"name" : "horizontalbar1", "tip":"horizontalbar", "x":TITLE_BAR_POS_X, "y":LABEL_START_Y+LABEL_GAP*1, "width":TITLE_BAR_WIDTH,
					"children" : ( { "name" : "horizontalbarName1", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", }, ),
				},
				{ 
					"name" : "horizontalbar2", "tip":"horizontalbar", "x":TITLE_BAR_POS_X, "y":LABEL_START_Y+LABEL_GAP*2, "width":TITLE_BAR_WIDTH,
					"children" : ( { "name" : "horizontalbarName2", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", }, ),
				},
				{ 
					"name" : "horizontalbar3", "tip":"horizontalbar", "x":TITLE_BAR_POS_X, "y":LABEL_START_Y+LABEL_GAP*3, "width":TITLE_BAR_WIDTH,
					"children" : ( { "name" : "horizontalbarName3", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", }, ),
				},
				{ 
					"name" : "horizontalbar4", "tip":"horizontalbar", "x":TITLE_BAR_POS_X, "y":LABEL_START_Y+LABEL_GAP*4, "width":TITLE_BAR_WIDTH,
					"children" : ( { "name" : "horizontalbarName4", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", }, ),
				},
				{ 
					"name" : "horizontalbar5", "tip":"horizontalbar", "x":TITLE_BAR_POS_X, "y":LABEL_START_Y+LABEL_GAP*5, "width":TITLE_BAR_WIDTH,
					"children" : ( { "name" : "horizontalbarName5", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", }, ),
				},
				{ 
					"name" : "horizontalbar6", "tip":"horizontalbar", "x":TITLE_BAR_POS_X, "y":LABEL_START_Y+LABEL_GAP*6, "width":TITLE_BAR_WIDTH,
					"children" : ( { "name" : "horizontalbarName6", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", }, ),
				},
				{ 
					"name" : "horizontalbar7", "tip":"horizontalbar", "x":TITLE_BAR_POS_X, "y":LABEL_START_Y+LABEL_GAP*7, "width":TITLE_BAR_WIDTH,
					"children" : ( { "name" : "horizontalbarName7", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", }, ),
				},
				{ 
					"name" : "horizontalbar8", "tip":"horizontalbar", "x":TITLE_BAR_POS_X, "y":LABEL_START_Y+LABEL_GAP*8, "width":TITLE_BAR_WIDTH,
					"children" : ( { "name" : "horizontalbarName8", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", }, ),
				},
				{ 
					"name" : "horizontalbar9", "tip":"horizontalbar", "x":TITLE_BAR_POS_X, "y":LABEL_START_Y+LABEL_GAP*9, "width":TITLE_BAR_WIDTH,
					"children" : ( { "name" : "horizontalbarName9", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", }, ),
				},
				{ 
					"name" : "horizontalbar10", "tip":"horizontalbar", "x":TITLE_BAR_POS_X, "y":LABEL_START_Y+LABEL_GAP*10, "width":TITLE_BAR_WIDTH,
					"children" : ( { "name" : "horizontalbarName10", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", }, ),
				},
				{ 
					"name" : "horizontalbar11", "tip":"horizontalbar", "x":TITLE_BAR_POS_X, "y":LABEL_START_Y+LABEL_GAP*11, "width":TITLE_BAR_WIDTH,
					"children" : ( { "name" : "horizontalbarName11", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", }, ),
				},
				{ 
					"name" : "horizontalbar12", "tip":"horizontalbar", "x":TITLE_BAR_POS_X, "y":LABEL_START_Y+LABEL_GAP*12, "width":TITLE_BAR_WIDTH,
					"children" : ( { "name" : "horizontalbarName12", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", }, ),
				}, ## yatay çubuk sonu
				
				## Etiket ##
				{
					"name" : "label0", "tip" : "thinboard_circle", "x" : LABEL_START_X, "y" : LABEL_START_Y+LABEL_GAP*0, "width" : LABEL_WIDTH, "height" : LABEL_HEIGHT,
					"horizontal_align" : "center",
					"children" : ( 
						{ "name" : "labelvalue0", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", },
					),
				},
				{
					"name" : "label1", "tip" : "thinboard_circle", "x" : LABEL_START_X, "y" : LABEL_START_Y+LABEL_GAP*1, "width" : LABEL_WIDTH, "height" : LABEL_HEIGHT,
					"horizontal_align" : "center",
					"children" : ( 
						{ "name" : "labelvalue1", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", },
					),
				},
				{
					"name" : "label2", "tip" : "thinboard_circle", "x" : LABEL_START_X, "y" : LABEL_START_Y+LABEL_GAP*2, "width" : LABEL_WIDTH, "height" : LABEL_HEIGHT,
					"horizontal_align" : "center",
					"children" : ( 
						{ "name" : "labelvalue2", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", },
					),
				},
				{
					"name" : "label3", "tip" : "thinboard_circle", "x" : LABEL_START_X, "y" : LABEL_START_Y+LABEL_GAP*3, "width" : LABEL_WIDTH, "height" : LABEL_HEIGHT,
					"horizontal_align" : "center",
					"children" : ( 
						{ "name" : "labelvalue3", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", },
					),
				},
				{
					"name" : "label4", "tip" : "thinboard_circle", "x" : LABEL_START_X, "y" : LABEL_START_Y+LABEL_GAP*4, "width" : LABEL_WIDTH, "height" : LABEL_HEIGHT,
					"horizontal_align" : "center",
					"children" : ( 
						{ "name" : "labelvalue4", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", },
					),
				},
				{
					"name" : "label5", "tip" : "thinboard_circle", "x" : LABEL_START_X, "y" : LABEL_START_Y+LABEL_GAP*5, "width" : LABEL_WIDTH, "height" : LABEL_HEIGHT,
					"horizontal_align" : "center",
					"children" : ( 
						{ "name" : "labelvalue5", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", },
					),
				},
				{
					"name" : "label6", "tip" : "thinboard_circle", "x" : LABEL_START_X, "y" : LABEL_START_Y+LABEL_GAP*6, "width" : LABEL_WIDTH, "height" : LABEL_HEIGHT,
					"horizontal_align" : "center",
					"children" : ( 
						{ "name" : "labelvalue6", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", },
					),
				},
				{
					"name" : "label7", "tip" : "thinboard_circle", "x" : LABEL_START_X, "y" : LABEL_START_Y+LABEL_GAP*7, "width" : LABEL_WIDTH, "height" : LABEL_HEIGHT,
					"horizontal_align" : "center",
					"children" : ( 
						{ "name" : "labelvalue7", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", },
					),
				},
				{
					"name" : "label8", "tip" : "thinboard_circle", "x" : LABEL_START_X, "y" : LABEL_START_Y+LABEL_GAP*8, "width" : LABEL_WIDTH, "height" : LABEL_HEIGHT,
					"horizontal_align" : "center",
					"children" : ( 
						{ "name" : "labelvalue8", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", },
					),
				},
				{
					"name" : "label9", "tip" : "thinboard_circle", "x" : LABEL_START_X, "y" : LABEL_START_Y+LABEL_GAP*9, "width" : LABEL_WIDTH, "height" : LABEL_HEIGHT,
					"horizontal_align" : "center",
					"children" : ( 
						{ "name" : "labelvalue9", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", },
					),
				},
				{
					"name" : "label10", "tip" : "thinboard_circle", "x" : LABEL_START_X, "y" : LABEL_START_Y+LABEL_GAP*10, "width" : LABEL_WIDTH, "height" : LABEL_HEIGHT,
					"horizontal_align" : "center",
					"children" : ( 
						{ "name" : "labelvalue10", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", },
					),
				},
				{
					"name" : "label11", "tip" : "thinboard_circle", "x" : LABEL_START_X, "y" : LABEL_START_Y+LABEL_GAP*11, "width" : LABEL_WIDTH, "height" : LABEL_HEIGHT,
					"horizontal_align" : "center",
					"children" : ( 
						{ "name" : "labelvalue11", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", },
					),
				},
				{
					"name" : "label12", "tip" : "thinboard_circle", "x" : LABEL_START_X, "y" : LABEL_START_Y+LABEL_GAP*12, "width" : LABEL_WIDTH, "height" : LABEL_HEIGHT,
					"horizontal_align" : "center",
					"children" : ( 
						{ "name" : "labelvalue12", "tip" : "text", "x" : 0, "y" : 0, "text" : "", "all_align" : "center", },
					),
				}, ## etiket sonu
				
				## Buton
				{ 
							"name" : "labelname0", "tip" : "button",
							"x" : LABEL_NAME_POS_X, "y" : LABEL_START_Y+LABEL_GAP*0, 
							
							"text" : "", 
							"horizontal_align" : "center",
							
							"default_image" : LOCALE_PATH + "details.sub",
							"over_image" : LOCALE_PATH + "details.sub",
							"down_image" : LOCALE_PATH + "details.sub",
				},
				{ 
							"name" : "labelname1", "tip" : "button",
							"x" : LABEL_NAME_POS_X, "y" : LABEL_START_Y+LABEL_GAP*1, 
							
							"text" : "", 
							"horizontal_align" : "center",
							
							"default_image" : LOCALE_PATH + "details.sub",
							"over_image" : LOCALE_PATH + "details.sub",
							"down_image" : LOCALE_PATH + "details.sub",
				},
				{ 
							"name" : "labelname2", "tip" : "button",
							"x" : LABEL_NAME_POS_X, "y" : LABEL_START_Y+LABEL_GAP*2, 
							
							"text" : "", 
							"horizontal_align" : "center",
							
							"default_image" : LOCALE_PATH + "details.sub",
							"over_image" : LOCALE_PATH + "details.sub",
							"down_image" : LOCALE_PATH + "details.sub",
				},
				{ 
							"name" : "labelname3", "tip" : "button",
							"x" : LABEL_NAME_POS_X, "y" : LABEL_START_Y+LABEL_GAP*3, 
							
							"text" : "", 
							"horizontal_align" : "center",
							
							"default_image" : LOCALE_PATH + "details.sub",
							"over_image" : LOCALE_PATH + "details.sub",
							"down_image" : LOCALE_PATH + "details.sub",
				},	
				{ 
							"name" : "labelname4", "tip" : "button",
							"x" : LABEL_NAME_POS_X, "y" : LABEL_START_Y+LABEL_GAP*4, 
							
							"text" : "", 
							"horizontal_align" : "center",
							
							"default_image" : LOCALE_PATH + "details.sub",
							"over_image" : LOCALE_PATH + "details.sub",
							"down_image" : LOCALE_PATH + "details.sub",
				},	
				{ 
							"name" : "labelname5", "tip" : "button",
							"x" : LABEL_NAME_POS_X, "y" : LABEL_START_Y+LABEL_GAP*5, 
							
							"text" : "", 
							"horizontal_align" : "center",
							
							
							"default_image" : LOCALE_PATH + "details.sub",
							"over_image" : LOCALE_PATH + "details.sub",
							"down_image" : LOCALE_PATH + "details.sub",
				},	
				{ 
							"name" : "labelname6", "tip" : "button",
							"x" : LABEL_NAME_POS_X, "y" : LABEL_START_Y+LABEL_GAP*6, 
							
							"text" : "", 
							"horizontal_align" : "center",
							
							"default_image" : LOCALE_PATH + "details.sub",
							"over_image" : LOCALE_PATH + "details.sub",
							"down_image" : LOCALE_PATH + "details.sub",
				},	
				{ 
							"name" : "labelname7", "tip" : "button",
							"x" : LABEL_NAME_POS_X, "y" : LABEL_START_Y+LABEL_GAP*7, 
							
							"text" : "", 
							"horizontal_align" : "center",
							
							"default_image" : LOCALE_PATH + "details.sub",
							"over_image" : LOCALE_PATH + "details.sub",
							"down_image" : LOCALE_PATH + "details.sub",
				},	
				{ 
							"name" : "labelname8", "tip" : "button",
							"x" : LABEL_NAME_POS_X, "y" : LABEL_START_Y+LABEL_GAP*8, 
							
							"text" : "", 
							"horizontal_align" : "center",
							
							"default_image" : LOCALE_PATH + "details.sub",
							"over_image" : LOCALE_PATH + "details.sub",
							"down_image" : LOCALE_PATH + "details.sub",
				},	
				{ 
							"name" : "labelname9", "tip" : "button",
							"x" : LABEL_NAME_POS_X, "y" : LABEL_START_Y+LABEL_GAP*9, 
							
							"text" : "", 
							"horizontal_align" : "center",
							
							"default_image" : LOCALE_PATH + "details.sub",
							"over_image" : LOCALE_PATH + "details.sub",
							"down_image" : LOCALE_PATH + "details.sub",
				},	
				{ 
							"name" : "labelname10", "tip" : "button",
							"x" : LABEL_NAME_POS_X, "y" : LABEL_START_Y+LABEL_GAP*10, 
							
							"text" : "", 
							"horizontal_align" : "center",
							
							"default_image" : LOCALE_PATH + "details.sub",
							"over_image" : LOCALE_PATH + "details.sub",
							"down_image" : LOCALE_PATH + "details.sub",
				},	
				{ 
							"name" : "labelname11", "tip" : "button",
							"x" : LABEL_NAME_POS_X, "y" : LABEL_START_Y+LABEL_GAP*11, 
							
							"text" : "", 
							"horizontal_align" : "center",
							
							"default_image" : LOCALE_PATH + "details.sub",
							"over_image" : LOCALE_PATH + "details.sub",
							"down_image" : LOCALE_PATH + "details.sub",
				},	
				{ 
							"name" : "labelname12", "tip" : "button",
							"x" : LABEL_NAME_POS_X, "y" : LABEL_START_Y+LABEL_GAP*12, 
							
							"text" : "", 
							"horizontal_align" : "center",
							
							"default_image" : LOCALE_PATH + "details.sub",
							"over_image" : LOCALE_PATH + "details.sub",
							"down_image" : LOCALE_PATH + "details.sub",
				}, ## buton sonu
				
			),
		}, ## MainBoard End
	),
}