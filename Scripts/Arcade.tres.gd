
var multiplicador = 1
var stage = 1
var score = 0
var scorepanel

func _ready():
	var scorepanel = global.root.find_node("Score", true, false).get_global_pos()
	set_fixed_process(true)

func _fixed_process(delta):
	scorepanel = score
	