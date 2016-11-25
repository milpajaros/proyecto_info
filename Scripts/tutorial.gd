
extends PanelContainer

var left=false
var right=false
var up=false
var down=false
var fire=false
var timer

func _ready():
	timer = get_node("Timer")
	set_process(true)
	
func _process(delta):
	if(Input.is_action_pressed("ui_left")):
		left=true
	if(Input.is_action_pressed("ui_right")):
		right = true
	if(Input.is_action_pressed("ui_up")):
		up = true
	if(Input.is_action_pressed("ui_down")):
		down = true
	if(Input.is_action_pressed("ui_accept")):
		fire = true
	if(left && right && up && down && fire):
		global.root.find_node("Guide", true, false).get_node("Sprite").set_hidden(false)
		get_node("text").set_bbcode("Muy bien, ahora derrota a esos malditos aliens.\n\nBastará con que destruyas su estación central.")
		set_process(false)
		timer.set_wait_time(5)
		timer.connect("timeout",self,"_timeout")
		timer.start()

func _timeout():
	self.queue_free()
