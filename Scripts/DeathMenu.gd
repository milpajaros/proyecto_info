
extends Container
var timer
var opacity

func _ready():
	opacity = 0
	set_hidden(true)

func game_over():
	global.current_scene.find_node("BGMusic",true,false).set_paused(true)
	if(global.music):
		get_node("DefeatMusic").play()
	get_parent().get_node("HPBoss").set_hidden(true)
	get_parent().get_node("HPbar").set_hidden(true)
	timer = get_node("Timer")
	timer.set_wait_time(5)
	timer.connect("timeout",self,"_timeout")
	timer.start()
	set_hidden(false)

func _on_reintentar_pressed():
	get_tree().set_pause(false)
	get_node("/root/global").goto_scene(global.current_scene_path)


func _on_Salir_pressed():
	get_tree().set_pause(false)
	get_node("/root/global").goto_scene("res://Scenes/main_menu.tscn")


func _on_Salir_mouse_enter():
	if(global.sound):
		get_parent().get_node("Sample").play("Bip")


func _on_reintentar_mouse_enter():
	if(global.sound):
		get_parent().get_node("Sample").play("Bip")

func _timeout():
	set_process(true)
	get_tree().set_pause(true)

func _process(delta):
	opacity = opacity + delta
	get_node("black").set_self_opacity(opacity)