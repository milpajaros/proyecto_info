
extends VBoxContainer


func _ready():
	set_process(true)
	OS.set_window_title("Space conquerers")

func _process(delta):
	pass

func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_Settings_pressed():
	pass # replace with function body


func _on_Exit_pressed():
	get_tree().quit()
