ROOT = "d:/ymir work/ui/game/"

window = {
	"name" : "IME",

	"x" : 100,
	"y" : 300,

	"width"		: 155,
	"height"	: 25,

	"children" :
	(
		## Board
		{
			"name" : "Base_Board_01",
			"tip" : "image",

			"x" : 0,
			"y" : 0,

			"image" : "d:/ymir work/ui/public/HorizontalCandidateBoard.sub"
		},
		{
			"name" : "CandidateList",
			"tip" : "candidate_list",

			"x" : 5 + 2,
			"y" : 10,

			"item_xsize" : 16,
			"item_ysize" : 16,

			"item_step" : 16,
		},
	),
}
