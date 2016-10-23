extends KinematicBody2D

const MAX_HP = 10
#variables para el disparo
onready var laser_scene = preload("res://scenes/laser_scene.xml")
var laser

var acceleration = 4000 #aceleración del player
var maxspeed = 400 #velocidad máxima
var velocity = Vector2() #vector velocidad
var shootcd = 0.15 #tiempo entre disparo y disparo
var actualcd = 0
var dead = false
var hp = 10


func _ready():
	get_node("ExplosionAnimation").set_hidden(true)
	set_fixed_process(true)


func _fixed_process(delta):
	get_parent().get_node("GUI/HPBar").set_val(hp*100/MAX_HP)
	actualcd -= delta
	var mousepos = get_global_mouse_pos()
	if(!dead):
		look_at(mousepos) #la nave apunta al raton
		
	if(hp <= 0):
		actualcd = delta
		if(!dead):
			dead = true
			_die()
	
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

func _on_BulletHitArea_body_enter( body ):
	if(body.has_method("_hit") && body.has_meta("enemigo")):
		hp -=1;
		body._hit()

func _die():
	acceleration = 0
	velocity = Vector2(0,0)
	get_node("PlayerAnimation").set_hidden(true)
	get_node("ExplosionAnimation").set_hidden(false)
	get_node("ExplosionAnimation").set_frame(0)
	get_node("ExplosionAnimation").play("default")