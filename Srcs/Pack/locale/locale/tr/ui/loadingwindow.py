import uiScriptLocale
import app

window = {

	"x" : 0,
	"y" : 0,

	"width" : SCREEN_WIDTH,
	"height" : SCREEN_HEIGHT,

	"children" :
	[
		## Board
		{
			"name" : "BackGround",
			"tip" : "expanded_image",

			"x" : 0,
			"y" : 0,

			"image" : "d:/ymir work/ui/intro/pattern/Line_Pattern.tga",

			"x_scale" : float(SCREEN_WIDTH) / 800.0,
			"y_scale" : float(SCREEN_HEIGHT) / 600.0,
		},
		{ 
			"name":"ErrorMessage", 
			"tip":"text", "x":10, "y":10, 
			"text": uiScriptLocale.LOAD_ERROR, 
		},
		
		{
			"name" : "GageBoard",
			"tip" : "window",
			"style" : ("ltr",),
			"x" : float(SCREEN_WIDTH) * 400 / 800.0 - 200,
			"y" : float(SCREEN_HEIGHT) * 500 / 600.0 ,
			"width" : 400, 
			"height": 80,

			"children" :
			(
			
				{
					"name" : "BackGage",
					"tip" : "expanded_image",

					"x" : 40,
					"y" : 25,

					"image" : uiScriptLocale.LOCALE_UISCRIPT_PATH + "loading/gauge_empty.dds",
				},
				{
					"name" : "FullGage",
					"tip" : "expanded_image",

					"x" : 40,
					"y" : 25,

					"image" : uiScriptLocale.LOCALE_UISCRIPT_PATH + "loading/gauge_full.dds",
				},
			),
		},
	],
}

window["children"] = window["children"] + [
{
	"name" : "TipBackground",
	"tip" : "middleboard",
	
	"x"	: 0,
	"y" : float(SCREEN_HEIGHT) * 500 / 600.0 - 100,
	
	"width" : SCREEN_WIDTH,
	"height" : 100,
	
	"children" :
	(
		{
			"name" : "LoadingTip",
			"tip" : "text",
			
			"x"	: float(SCREEN_WIDTH) / 2,
			"y" : 40,				
			
			"text" : " ",
			"text_horizontal_align" : "center",
			"fontsize" : "LARGE",
		},
	),		
},]