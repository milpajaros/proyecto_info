
extends KinematicBody2D
var laser = preload("res://scenes/laser_scene.xml")

var speed = 500

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here

	
	set_fixed_process(true)

func _fixed_process(delta):
	move_local_y(speed*delta, true)
		#necesito que cada hijo tenga la variable inherente a el vector y mouse pos
