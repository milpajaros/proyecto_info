extends KinematicBody2D

#variables para el disparo
onready var laser_scene = preload("res://scenes/laser_scene.xml")
var laser

var acceleration = 4000 #aceleración del player
var maxspeed = 400 #velocidad máxima
var velocity = Vector2() #vector velocidad
var shootcd = 0.15 #tiempo entre disparo y disparo
var actualcd = 0


func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	actualcd -= delta
	var mousepos = get_global_mouse_pos()
	look_at(mousepos) #la nave apunta al raton
	
	#deteccion de movimiento
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
	
	#condicion de parada
	if(!Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right")):
		velocity.x=0
	if(!Input.is_action_pressed("ui_up") && !Input.is_action_pressed("ui_down")):
		velocity.y=0        
	
	#Deteccion de colisiones
	if (is_colliding()):
		var n = get_collision_normal()
		velocity = n.slide(velocity)

	move(velocity*delta)
	
	#mecanica del disparo
	if(Input.is_action_pressed("ui_accept") && (actualcd <= 0)):
		actualcd = shootcd #reinicia el CD
		laser = laser_scene.instance()
		var playerpos = get_node("PlayerAnimation").get_pos()
		var LaserSpawnPoint = get_node("LaserSpawnPoint").get_global_pos()
		var laserHolder = get_node("LaserHolder")
		laserHolder.add_child(laser)
		laser.set_meta("aliado",1)
		laser.set_pos(LaserSpawnPoint)
		laser.look_at(get_global_mouse_pos())