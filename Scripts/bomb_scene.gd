
extends KinematicBody2D
var bomb = preload("res://scenes/bomb_scene.xml")
var speed = 50
var timer
var dmg = 5


func _ready():
	timer = get_node("time_left")

	timer.set_wait_time(5)
	timer.connect("timeout",self,"_timeout")
	timer.start()
	self.look_at(get_tree().get_root().get_node("Root/Player").get_pos())
	set_process(true)
	set_meta("arma",1)

func _process(delta):
	move_local_y(speed*delta, true)
	
	
func _timeout():
	
	for body in get_node("AreaExplosion").get_overlapping_bodies():
		if (!body.has_meta("arma")):
			_hit(body)
	self.queue_free()
	
	
func _hit(body):
	if body.has_meta("aliado"):
		body.hp= body.hp-dmg
	speed = 0
func die():
	pass



