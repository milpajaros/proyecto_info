
extends Container


func _ready():
	set_hidden(true)

func game_over():
	set_hidden(false)

func _on_reintentar_pressed():
	get_node("/root/global").goto_scene("res://Scenes/World.tscn")


func _on_Salir_pressed():
	get_node("/root/global").goto_scene("res://Scenes/main_menu.tscn")
