extends Node2D

onready var laser_scene = preload("res://scenes/laser_scene.xml")
var laserenemigo = preload("res://Textures/laserRed.png")

var sectors = 3
var bossmode = false
var dead = false
var timer
var hp = 200
var attackmode = 0
var playerpos
var actualcd = 0
var enemycd = 1
var bulletTTL = 2
var variation = 0
var phasetime = 5

func _ready():
	playerpos = get_parent().get_node("Player").get_pos()
	get_node("Center/ExplosionHolder").set_hidden(true)
	set_fixed_process(true)

func _fixed_process(delta):
	if((sectors <=0) && !bossmode ):
		print("bossmode on")
		bossmode = true
		get_node("Center/BossExtendedHitbox").queue_free()
		timer = get_node("BossTimer")
		timer.set_wait_time(phasetime)
		timer.connect("timeout",self,"_nextphase")
		timer.start()
	if(bossmode):
		playerpos = get_parent().get_node("Player").get_pos()
		actualcd -= delta
		_rampage()
	if((hp <= 0) && !dead):
		dead = true
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

func _on_DamageArea_body_enter( body ):
	if(body.has_method("_hit") && body.has_meta("aliado") && bossmode):
		body._hit(self)
		
func _nextphase():
	variation = 0
	actualcd = 0.5
	attackmode = randi() % 6
	print("NExtphase ", attackmode)
	timer = get_node("BossTimer")
	timer.set_wait_time(phasetime)
	timer.start()
	if(attackmode == 0):
		enemycd= 1
	if(attackmode == 1):
		enemycd = 0
	if(attackmode == 2):
		enemycd= 0.1
	if(attackmode == 3):
		enemycd= 0
	if(attackmode == 4):
		enemycd= 1
	if(attackmode == 5):
		enemycd= 0.4

func _die():
	attackmode = 10
	timer = get_node("BossTimer")
	timer.set_wait_time(5)
	timer.connect("timeout",self,"_timeout")
	timer.start()
	get_node("Center/ExplosionHolder").set_hidden(false)
	for N in get_node("Center/ExplosionHolder").get_children():
		if(N.has_method("play")):
			N.set_frame(0)
			N.play("default")
func _timeout():
	hide()
	queue_free()

func _patron0():
	if(actualcd <= 0):
		for n in range(36):
			_firerot((variation+n)*10)
		actualcd = enemycd #reinicia el CD
		variation+= 0.25
func _patron1():
	if(actualcd <= 0):
		_fireat(playerpos)
		actualcd = enemycd #reinicia el CD
func _patron2():
	if(actualcd <= 0):
		for n in range(9):
			_firerot((variation+n)*40)
		actualcd = enemycd #reinicia el CD
		variation+= 0.1
func _patron3():
	if(actualcd <= 0):
		_firerot(variation)
		actualcd = enemycd #reinicia el CD
		variation = randi()%360
func _patron4():
	if(actualcd <= 0):
		for n in range(30):
			_firerot((variation+n*3))
		actualcd = enemycd #reinicia el CD
		variation+= (randi()%4 * 90)
func _patron5():
	if(actualcd <= 0):
		for n in range(2):
			_firerot(variation+ n*180)
		for n in range(2):
			_firerot(-(variation+90+n*180))
		actualcd = enemycd #reinicia el CD
		variation+= 7.2

func _fireat(shootat):
	var laser = laser_scene.instance()
	laser.get_node("LaserSprite").set_texture(laserenemigo)
	var enemypos = get_pos()
	laser.set_meta("enemigo",0)
	var LaserSpawnPoint = get_pos()
	var laser_holder = get_node("LaserHolder")
	laser.set_pos(LaserSpawnPoint)
	laser.look_at(shootat)
	laser.ttl = bulletTTL
	laser_holder.add_child(laser)

func _firerot(rotation):
	var laser = laser_scene.instance()
	laser.get_node("LaserSprite").set_texture(laserenemigo)
	var enemypos = get_pos()
	laser.set_meta("enemigo",0)
	var LaserSpawnPoint = get_pos()
	var laser_holder = get_node("LaserHolder")
	laser.set_pos(LaserSpawnPoint)
	laser.rotate(deg2rad(rotation))
	laser.ttl = bulletTTL
	laser_holder.add_child(laser)