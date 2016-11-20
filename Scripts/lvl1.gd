
extends Node
onready var player_scene = preload("res://scenes/player.xml")
var player

func _ready():
	get_node("CanvasLayer/VictoryScreen").set_hidden(true)
	set_fixed_process(false)

func victory():
	set_fixed_process(true)
	get_node("BGMusic").set_paused(true)
	get_node("VictoryMusic").play_loop(11)
	get_node("CanvasLayer/VictoryScreen").set_hidden(false)
	find_node("Guide",true,false).queue_free()

func _fixed_process(delta):
	find_node("PlayerCamera",true,false).set_global_pos(get_node("Boss").get_global_pos())

func next_level():
	set_fixed_process(false)
	get_node("/root/global").goto_scene("res://Scenes/main_menu.tscn")