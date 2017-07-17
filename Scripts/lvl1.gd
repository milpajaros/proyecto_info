
extends Node
var player
var opacity = 0
var timer

func _ready():
	player = global.root.find_node("Player",true, false)
	global.root.find_node("Score",true, false).set_hidden(true)
	global.wasplaying = get_node("BGMusic")
	if(global.music):
		get_node("BGMusic").play()
	get_node("CanvasLayer/VictoryScreen").set_hidden(true)
	set_fixed_process(false)

func victory():
	player = global.root.find_node("Player",true, false)
	player.pause(true)
	get_node("BGMusic").set_paused(true)
	if(global.music):
		global.wasplaying = get_node("VictoryMusic")
		get_node("VictoryMusic").play_loop(11)
	get_node("CanvasLayer/VictoryScreen").set_hidden(false)
	find_node("Guide",true,false).queue_free()
	get_node("CanvasLayer/Black").set_hidden(false)
	set_process(true)
	timer = get_node("CanvasLayer/Timer")
	timer.set_wait_time(5)
	timer.connect("timeout",self,"_timeout")
	timer.start()

func next_level():
	set_process(false)
	get_node("/root/global").goto_scene("res://Scenes/level3.tscn")
	
func _timeout():
	next_level()
	
func _process(delta):
	opacity = opacity + delta/2
	get_node("CanvasLayer/Black").set_self_opacity(opacity)
