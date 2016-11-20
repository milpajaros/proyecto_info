
extends VBoxContainer
onready var musichover = preload("res://Textures/Buttons/musichover.png")
onready var music = preload("res://Textures/Buttons/music.png")
onready var nomusic = preload("res://Textures/Buttons/nomusic.png")
onready var nomusichover = preload("res://Textures/Buttons/nomusichover.png")
onready var soundhover = preload("res://Textures/Buttons/soundhover.png")
onready var sound = preload("res://Textures/Buttons/sound.png")
onready var nosound = preload("res://Textures/Buttons/nosound.png")
onready var nosoundhover = preload("res://Textures/Buttons/nosoundhover.png")

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
	if(global.sound):
		get_parent().get_node("Sample").play("Bip")


func _on_Play_mouse_enter():
	if(global.sound):
		get_parent().get_node("Sample").play("Bip")


func _on_Music_pressed():
	var musicbutton = get_parent().get_node("Container/Music")
	if(global.music == true):
		global.music = false
		get_parent().get_node("StreamPlayer").stop()
		musicbutton.set_normal_texture(nomusic)
		musicbutton.set_hover_texture(nomusichover)
	elif(global.music == false):
		global.music=true
		get_parent().get_node("StreamPlayer").play()
		musicbutton.set_normal_texture(music)
		musicbutton.set_hover_texture(musichover)


func _on_Sound_pressed():
	var soundbutton = get_parent().get_node("Container/Sound")
	if(global.sound == true):
		global.sound=false
		soundbutton.set_normal_texture(nosound)
		soundbutton.set_hover_texture(nosoundhover)
	elif(global.sound == false):
		global.sound=true
		soundbutton.set_normal_texture(sound)
		soundbutton.set_hover_texture(soundhover)

func _on_Music_mouse_enter():
	if(global.sound):
		get_parent().get_node("Sample").play("Bip")


func _on_Sound_mouse_enter():
	if(global.sound):
		get_parent().get_node("Sample").play("Bip")
