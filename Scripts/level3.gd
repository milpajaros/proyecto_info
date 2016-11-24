
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	get_node("BGMusic").play()
	get_node("CanvasLayer/Victory screen").set_hidden(true)

func victory():
	get_node("CanvasLayer/Victory screen").set_hidden(false)

func _on_DiamanteArea_body_enter( body ):
	if(body.has_meta("aliado") && body.has_meta("nave")):
		get_node("Diamante").queue_free()
		get_node("Player").pause(true)
		find_node("Guide",true,false).queue_free()
		_final_boss()

func _final_boss():
	