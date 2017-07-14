
extends Container
onready var musichover = preload("res://Textures/Buttons/musichover.png")
onready var music = preload("res://Textures/Buttons/music.png")
onready var nomusic = preload("res://Textures/Buttons/nomusic.png")
onready var nomusichover = preload("res://Textures/Buttons/nomusichover.png")
onready var soundhover = preload("res://Textures/Buttons/soundhover.png")
onready var sound = preload("res://Textures/Buttons/sound.png")
onready var nosound = preload("res://Textures/Buttons/nosound.png")
onready var nosoundhover = preload("res://Textures/Buttons/nosoundhover.png")

var musicbutton
var soundbutton

var wasplaying
func _ready():
	soundbutton = get_node("Sound")
	musicbutton = get_node("Music")
	if(global.music):
		musicbutton.set_normal_texture(music)
		musicbutton.set_hover_texture(musichover)
	elif(!global.music):
		musicbutton.set_normal_texture(nomusic)
		musicbutton.set_hover_texture(nomusichover)
	if(!global.sound):
		soundbutton.set_normal_texture(nosound)
		soundbutton.set_hover_texture(nosoundhover)
	elif(global.sound):
		soundbutton.set_normal_texture(sound)
		soundbutton.set_hover_texture(soundhover)
	set_hidden(true)
	set_process_input(true)

func _input(event):
	var player = global.root.find_node("Player",true,false)
	if(!get_tree().is_paused() && event.is_action_pressed("ui_exit") && player.is_alive()):
		set_hidden(false)
		get_tree().set_pause(true)
		var tuto = global.root.find_node("Tutorial",true, false)
		if (tuto != null):
			tuto.set_hidden(true)
			global.root.find_node("Guide", true, false).get_node("Sprite").set_hidden(false)
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


func _on_Salir_mouse_enter():
	if(global.sound):
		get_parent().get_node("Sample").play("Bip")


func _on_Continuar_mouse_enter():
	if(global.sound):
		get_parent().get_node("Sample").play("Bip")


func _on_Music_pressed():
	if(global.music):
		if(global.root.find_node("BGMusic",true,false).is_playing()):
			global.wasplaying=global.root.find_node("BGMusic",true,false)
			global.wasplaying.stop()
		if(global.root.find_node("VictoryMusic",true,false).is_playing()):
			global.wasplaying=global.root.find_node("VictoryMusic",true,false)
			global.wasplaying.stop()
		if(global.root.find_node("DefeatMusic",true,false).is_playing()):
			global.wasplaying=global.root.find_node("DefeatMusic",true,false)
			global.wasplaying.stop()
		if(global.root.find_node("BossMusic",true,false).is_playing()):
			global.wasplaying=global.root.find_node("BossMusic",true,false)
			global.wasplaying.stop()
		global.music = false
		musicbutton.set_normal_texture(nomusic)
		musicbutton.set_hover_texture(nomusichover)
	elif(!global.music):
		global.music=true
		global.wasplaying.play()
		musicbutton.set_normal_texture(music)
		musicbutton.set_hover_texture(musichover)


func _on_Sound_pressed():
	if(global.sound):
		global.sound=false
		soundbutton.set_normal_texture(nosound)
		soundbutton.set_hover_texture(nosoundhover)
	elif(!global.sound):
		global.sound=true
		soundbutton.set_normal_texture(sound)
		soundbutton.set_hover_texture(soundhover)

func _on_Music_mouse_enter():
	if(global.sound):
		get_parent().get_node("Sample").play("Bip")


func _on_Sound_mouse_enter():
	if(global.sound):
		get_parent().get_node("Sample").play("Bip")

func _on_Reset_pressed():
	get_tree().set_pause(false)
	get_node("/root/global").goto_scene(global.current_scene_path)

func _on_Reset_mouse_enter():
	if(global.sound):
		get_parent().get_node("Sample").play("Bip")
