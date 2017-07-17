
extends Container
var timer
var opacity

func _ready():
	opacity = 0
	get_node("input").set_hidden(true)
	get_node("input/LineEdit").set_text(global.username)
	set_hidden(true)

func game_over():
	
	global.root.find_node("BGMusic",true,false).set_paused(true)
	global.root.find_node("BossMusic",true,false).set_paused(true)
	if(global.music):
		get_node("DefeatMusic").play()
	get_parent().get_node("HPBoss").set_hidden(true)
	get_parent().get_node("HPbar").set_hidden(true)
	timer = get_node("Timer")
	timer.set_wait_time(5)
	timer.connect("timeout",self,"_timeout")
	timer.start()
	set_hidden(false)
	if(global.arcade):
		get_node("input").set_hidden(false)
		get_node("Buttons/reintentar").set_hidden(true)

func _on_reintentar_pressed():
	if(global.arcade):
		global.username = get_node("input/LineEdit").get_text()
		if(global.username.length() < 3):
			get_node("input/text").set_bbcode("Al menos 3 caracteres:")
			return
		else:
			save_score()
	get_tree().set_pause(false)
	get_node("/root/global").goto_scene(global.current_scene_path)
	


func _on_Salir_pressed():
	if(global.arcade):
		global.username = get_node("input/LineEdit").get_text()
		if(global.username.length() < 3):
			get_node("input/text").set_bbcode("Al menos 3 caracteres:")
			pass
		else:
			save_score()
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
	
func save_score():
	var file = File.new()
	if(file.file_exists("res://scores.dat")):
		file.open("res://scores.dat", 3)
		file.seek_end()
	else:
		file.open("res://scores.dat", 2)
	file.store_string(str(global.score) + " " + global.username + "\n")
	file.close()