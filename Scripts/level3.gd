
extends Node

var zoom =1
var timer
var opacity =0

func _ready():
	get_node("Boss").set_hidden(true)
	global.root.find_node("Score",true, false).set_hidden(true)
	if global.music:
		get_node("BGMusic").play()
	global.wasplaying = get_node("BGMusic")
	get_node("CanvasLayer/Victory screen").set_hidden(true)
	timer =get_node("Timer")
	timer.set_wait_time(5)
	timer.connect("timeout",self,"_endtuto")
	timer.start()

func victory():
	get_node("CanvasLayer/Victory screen").set_hidden(false)
	global.root.find_node("Player",true,false).pause(true)
	get_node("CanvasLayer/Tutorial/Text").set_bbcode("Gracias por habernos traido la paz.\nY por jugar a Space Conqueror.")
	get_node("CanvasLayer/Tutorial").set_hidden(false)
	timer.set_wait_time(7)
	timer.connect("timeout",self,"_timeout")
	timer.start()
	

func _on_DiamanteArea_body_enter( body ):
	if(body.has_meta("aliado") && body.has_meta("nave")):
		get_node("Diamante").queue_free()
		get_node("Player").pause(true)
		find_node("Guide",true,false).queue_free()
		get_node("BG").stop()
		_final_boss()

func _final_boss():
	get_node("Boss").set_hidden(false)
	set_process(true)
	get_node("VictoryMusic").stop_loop()
	if global.music:
		get_node("BossMusic").play_loop(90)
	global.wasplaying = get_node("BossMusic")

func _process(delta):
	if( zoom <2):
		zoom =zoom + delta
		global.root.find_node("PlayerCamera",true, false).set_zoom(Vector2(zoom,zoom))
	elif(zoom >=2 && opacity <1):
		opacity = opacity + delta
		get_node("Boss").set_opacity(opacity)
	elif(zoom >=2 && opacity >=1):
		get_node("Player").pause(false)
		get_node("Boss").start()
		set_process(false)
		

func _endtuto():
	find_node("Tutorial").set_hidden(true)

func _timeout():
	get_node("/root/global").goto_scene("res://Scenes/main_menu.tscn")