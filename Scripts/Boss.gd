extends Node2D

onready var laser_scene = preload("res://scenes/laser_scene.xml")
var laserenemigo = preload("res://Textures/laserRed.png")

var sectors = 3
var bossmode = false
var timer
var hp = 500
var attackmode = 0

func _ready():
	get_node("Center/ExplosionHolder").set_hidden(true)
	set_fixed_process(true)

func _fixed_process(delta):
	if((sectors <=0) && !bossmode ):
		bossmode = true
		get_node("Center/BossExtendedHitbox").queue_free()
		timer = get_node("BossTimer")
		timer.set_wait_time(10)
		timer.connect("timeout",self,"_nextphase")
		timer.start()
	if(bossmode):
		_rampage()
	if(hp <= 0):
		_die()

func _rampage():
	if(attackmode == 0):
		_patron0()
	if(attackmode == 1):
		_patron1()
	if(attackmode == 2):
		_patron2()
	if(attackmode == 3):
		_patron3()
	if(attackmode == 4):
		_patron4()
	if(attackmode == 5):
		_patron5()
	if(attackmode == 6):
		_patron6()
	if(attackmode == 7):
		_patron7()
	if(attackmode == 8):
		_patron8()
	if(attackmode == 9):
		_patron9()

func _on_DamageArea_body_enter( body ):
	if(body.has_method("_hit") && body.has_meta("aliado") && bossmode):
		body._hit(self)
		
func _nextphase():
	attackmode = randi()%10
	timer = get_node("BossTimer")
	timer.set_wait_time(10)
	timer.connect("timeout",self,"_nextphase")
	timer.start()

func _die():
	attackmode = 10
	timer = get_node("BossTimer")
	timer.set_wait_time(5)
	timer.connect("timeout",self,"_timeout")
	timer.start()
	get_node("Center/ExplosionHolder").set_hidden(false)
	for N in get_node("ExplosionHolder").get_children():
		if(N.has_method("play")):
			N.set_frame(0)
			N.play("default")
func _timeout():
	hide()
	queue_free()