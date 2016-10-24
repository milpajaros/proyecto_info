
extends KinematicBody2D
var laser = preload("res://scenes/bomb_scene.xml")
var speed = 200
var timer


func _ready():
	timer = get_node("time_left")
	timer.set_wait_time(5)
	timer.connect("timeout",self,"_timeout")
	timer.start()
	set_process(true)

func _process(delta):
	move_local_y(speed*delta, true)
	
	
func _timeout():
	
	for body in get_node("Areabomb").get_overlapping_bodies():
		if (!body.has_meta("arma")):
			_hit(2,body)
	self.queue_free()
	
	
func _hit(dmg, body):
	body.hp= body.hp-dmg
	speed = 0



