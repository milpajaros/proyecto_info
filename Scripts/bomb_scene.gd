
extends KinematicBody2D
var bomb = preload("res://scenes/bomb_scene.xml")
var speed = 50
var timer
var ttl = 5
var blinkstate =3
var dmg = 5
var hp = 3


func _ready():
	get_node("explosion").set_hidden(true)
	get_node("area").set_hidden(false)
	get_node("area").set_frame(0)
	get_node("area").play("velocidad1")
	timer = get_node("time_left")

	timer.set_wait_time(ttl)
	timer.connect("timeout",self,"_timeout")
	timer.start()
	self.look_at(get_tree().get_root().get_node("Root/Player").get_pos())
	set_process(true)
	set_meta("arma",1)

func _process(delta):
	if (hp>0):
		_parpadeo()
		move_local_y(speed*delta, true)
	else:
		_explode()
	
	
	
func _timeout():
	get_node("explosion").set_hidden(false)
	get_node("area").set_hidden(true)
	get_node("Sprite").set_hidden(true)
	timer.set_wait_time(0.1)
	get_node("explosion").set_frame(0)
	get_node("explosion").play("default")
	timer.connect("timeout",self,"_explode")
	timer.start()

	
func _parpadeo():
	var Tleft =timer.get_time_left()/ttl
	if((Tleft< 0.75) && blinkstate == 3):
		blinkstate = 2
		get_node("area").play("velocidad2")
	elif((Tleft< 0.5) && blinkstate == 2):
		blinkstate = 1
		get_node("area").play("velocidad3")
	elif((Tleft< 0.25) && blinkstate == 1):
		blinkstate = 0
		get_node("area").play("velocidad4")

func _hit(body):
	if body.has_meta("aliado"):
		body.hp= body.hp-dmg
	speed = 0
	
func _explode():
	for body in get_node("AreaExplosion").get_overlapping_bodies():
		if (!body.has_meta("arma")):
			_hit(body)
	self.queue_free()





func _on_Areabomb_body_enter( body ):
	if (body.has_meta("arma")):
			body._hit(self)
	elif(!body.has_meta("enemigo")):
			_explode()

