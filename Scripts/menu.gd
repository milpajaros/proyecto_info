
extends VBoxContainer


func _ready():
	set_process(true)
	OS.set_window_title("Space conqueror")

func _process(delta):
	pass

func _on_Play_pressed():
	  get_node("/root/global").goto_scene("res://Scenes/World.tscn")


func _on_Settings_pressed():
	var popup = get_parent().get_node("PopupPanel")
	if(popup.is_hidden()):
		popup.set_hidden(false)
	else:
		popup.set_hidden(true)

func _on_Exit_pressed():
	get_tree().quit()

func _on_Exit_mouse_enter():
	get_parent().get_node("Sample").play("Bip")


func _on_Play_mouse_enter():
	get_parent().get_node("Sample").play("Bip")
