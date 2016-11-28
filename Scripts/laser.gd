
extends KinematicBody2D
var laser = preload("res://Scenes/laser_scene.xml")

var speed = 1500
var timer
var dmg = 1
var ttl = 2
var timerset = false

func _ready():
	timer = get_node("LaserTTL")
	set_meta("arma", 1)
	get_node("HitAnimation").set_hidden(true)
	get_node("EnemyHitAnimation").set_hidden(true)
	
	set_fixed_process(true)

func _fixed_process(delta):
	if(timerset == false):
		timer.set_wait_time(ttl)
		timer.connect("timeout",self,"_timeout")
		timer.start()
		timerset= true
	
	move_local_y(speed*delta, true)
	if(is_colliding()):
		print("ouch")
	
func _timeout():
	hide()
	self.queue_free()

func _hit(body):
	if(global.sound):
		get_node("Sample").play("Explosion")
	body.hp = body.hp - dmg
	speed = 0
	get_node("LaserSprite").set_hidden(true)
	if(has_meta("enemigo")):
		get_node("EnemyHitAnimation").set_hidden(false)
		get_node("EnemyHitAnimation").set_frame(0)
		get_node("EnemyHitAnimation").play("default")
	else:
		get_node("HitAnimation").set_hidden(false)
		get_node("HitAnimation").set_frame(0)
		get_node("HitAnimation").play("default")
	timer.set_wait_time(0.5)

	timer.start()