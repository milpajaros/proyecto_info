
extends KinematicBody2D
var laser = preload("res://scenes/laser_scene.xml")

var speed = 500
var timer


func _ready():

	timer = get_node("LaserTTL")
	timer.set_wait_time(2)
	timer.connect("timeout",self,"_timeout")
	timer.start()
	
	set_fixed_process(true)

func _fixed_process(delta):
	
	move_local_y(speed*delta, true)
	
func _timeout():
	self.queue_free()
