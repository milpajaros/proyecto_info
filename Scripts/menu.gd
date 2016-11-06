
extends Node2D


var index = 0

func _ready():
	set_process_input(true)
	OS.set_window_title("Space conquerers")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event.is_action_pressed("ui_up"):
		if (index!=0):
			index -=1
			var y = get_node("seleccionado").get_pos().y - 100
			var x = 0
			get_node("seleccionado").set_pos(Vector2(x,y))
		else:
			index = 2
			var y = get_node("seleccionado").get_pos().y +200
			var x = 0
			get_node("seleccionado").set_pos(Vector2(x,y))
	if event.is_action_pressed("ui_down"):
		if (index!=2):
			index +=1
			var y = get_node("seleccionado").get_pos().y + 100
			var x = 0
			get_node("seleccionado").set_pos(Vector2(x,y))
		else:
			index = 0
			var y = get_node("seleccionado").get_pos().y -200
			var x = 0
			get_node("seleccionado").set_pos(Vector2(x,y))
	if (event.is_action_pressed("ui_accept")):
		if (index==0):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().change_scene("res://Scenes/World.tscn")
		if (index ==0):
			#MENU OPCIONES OTRA ESCENA
			pass
		if (index == 2):
			OS.get_main_loop().quit()

