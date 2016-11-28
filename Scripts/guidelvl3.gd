
extends Node2D
var bosspos

func _ready():
	get_node("Sprite").set_hidden(false)
	set_process(true)

func _process(delta):
	bosspos = Vector2(0,0)
	look_at(bosspos)
	var distancia = get_parent().get_pos().distance_to(bosspos)
	if(distancia > 1000):
		set_hidden(false)
	else:
		set_hidden(true)