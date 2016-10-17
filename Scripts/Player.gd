extends KinematicBody2D

onready var laser_scene = preload("res://scenes/laser_scene.xml")
var laser

var acceleration = 4000
var maxspeed = 400
var velocity = Vector2()
var slowspeed= 0



func _ready():
	set_fixed_process(true)

func _fixed_process(delta):

	var mousepos = get_global_mouse_pos()
	look_at(mousepos)
	
	if(Input.is_action_pressed("ui_left")):
		if(velocity.x > -maxspeed):
			velocity.x -= delta*acceleration
	if(Input.is_action_pressed("ui_right")):
		if(velocity.x < maxspeed):
			velocity.x += delta*acceleration
	if(Input.is_action_pressed("ui_up")):
		if(velocity.y > -maxspeed):
			velocity.y -= delta*acceleration
	if(Input.is_action_pressed("ui_down")):
		if(velocity.y < maxspeed):
			velocity.y += delta*acceleration

	if(!Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right")):
		velocity.x=0
	if(!Input.is_action_pressed("ui_up") && !Input.is_action_pressed("ui_down")):
		velocity.y=0        
	
	var movement = velocity*delta
	movement =move(movement)
	if (is_colliding()):
		var n = get_collision_normal()
		movement = n.slide(movement)
		velocity = n.slide(velocity)
	if(Input.is_action_pressed("ui_accept")):
		laser = laser_scene.instance()
		var playerpos = get_node("PlayerSprite").get_pos()
		var LaserSpawnPoint = get_node("LaserSpawnPoint").get_global_pos()
		var laserHolder = get_node("LaserHolder")
		laserHolder.add_child(laser)
		laser.set_pos(LaserSpawnPoint)
		laser.look_at(get_global_mouse_pos())