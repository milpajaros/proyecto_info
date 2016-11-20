
extends KinematicBody2D
onready var laser_scene = preload("res://scenes/laser_scene.xml")
var laserenemigo = preload("res://Textures/laserRed.png")
# member variables here, example:
# var a=2
# var b="textvar"
var laser
var enemycd = 0.5
var actualcd = 0
var DistanciaProxima = 200
var player
const SPEED = 200
var speed = SPEED
var maxhp = 5
var hp = maxhp
var timer
var dead = false
var distancia
var sampler

func _ready():
	sampler = get_node("SamplePlayer")
	actualcd = 2
	timer = get_node("EnemyTimer")
	timer.set_wait_time(60)
	timer.connect("timeout",self,"_timeout")
	timer.start()
	get_node("ExplosionAnimation").set_hidden(true)
	set_fixed_process(true)
	set_meta("nave",2)

func _on_Area_body_enter( body ):
	if(body.has_method("_hit") && body.has_meta("aliado")):
		body._hit(self)

func _fixed_process(delta):
	player = global.root.find_node("Player",true,false)
	get_node("Hpholder/HP").set_val(hp*100/maxhp)
	get_node("Hpholder").set_rot(-get_rot())
	actualcd -= delta
	distancia= get_pos().distance_to(player.get_pos())
	if(distancia < 1000):
		_chase(delta)
	if(distancia <500):
		_fire()
	if(hp <= 0):
		if(!dead):
			dead = true
			_die()

func _fire():
	if(actualcd<=0 && !dead):
		actualcd = enemycd #reinicia el CD
		laser = laser_scene.instance()
		laser.get_node("LaserSprite").set_texture(laserenemigo)
		var enemypos = get_pos()
		laser.set_meta("enemigo",1)
		var LaserSpawnPoint = get_pos()
		var laser_holder = get_node("LaserHolder")
		laser.set_pos(LaserSpawnPoint)
		laser.look_at(player.get_pos())
		laser_holder.add_child(laser)
		sampler.play("Shot")

func _chase(delta):
	if(!dead):
		look_at(player.get_pos())
	var movement = Vector2(player.get_pos().x-get_pos().x,player.get_pos().y-get_pos().y)
	movement = movement.normalized()
	if(distancia < DistanciaProxima):
		var n = movement.tangent()
		movement = movement.slide(n)
	
	movement = move(movement*delta*speed)
	if (is_colliding()):
		var n = get_collision_normal()
		movement = n.slide(movement)
		move(movement)

func _die():
	get_node("Hpholder").set_hidden(true)
	hp = 0
	speed = 0
	timer.set_wait_time(1)
	timer.start()
	get_node("EnemySprite").set_hidden(true)
	get_node("ExplosionAnimation").set_hidden(false)
	get_node("ExplosionAnimation").set_frame(0)
	get_node("ExplosionAnimation").play("default")
	sampler.play("Explosion")
	
func _timeout():
	hide()
	self.queue_free()