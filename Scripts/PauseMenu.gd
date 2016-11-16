
extends Container

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_hidden(true)
	set_process_input(true)

func _input(event):
	var player = global.root.find_node("Player",true,false)
	if(!get_tree().is_paused() && event.is_action_pressed("ui_exit") && player.is_alive()):
		set_hidden(false)
		get_tree().set_pause(true)
	elif(get_tree().is_paused() && event.is_action_pressed("ui_exit")):
		set_hidden(true)
		get_tree().set_pause(false)
	get_tree().set_input_as_handled()

func _on_Continuar_pressed():
	set_hidden(true)
	get_tree().set_pause(false)


func _on_Salir_pressed():
	get_tree().set_pause(false)
	get_node("/root/global").goto_scene("res://Scenes/main_menu.tscn")
