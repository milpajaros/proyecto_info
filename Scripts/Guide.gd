
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var bosspos

func _ready():
	set_hidden(true)
	set_process(true)

func _process(delta):
	bosspos = global.root.find_node("Center", true, false).get_global_pos()
	look_at(bosspos)
	var distancia = get_parent().get_pos().distance_to(bosspos)
	if(distancia > 1000):
		set_hidden(false)
	else:
		set_hidden(true)