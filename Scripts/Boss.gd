extends Node2D

onready var laser_scene = preload("res://scenes/laser_scene.xml")
var laserenemigo = preload("res://Textures/laserRed.png")
var sampler

var sectors = 3
var bossmode = false
var dead = false
var timer
var maxhp = 200
var hp = maxhp
var attackmode = 0
var playerpos
var actualcd = 0
var enemycd = 1
var bulletTTL = 2
var variation = 0
var phasetime = 5
var dmg = 1

func _ready():
	sampler = get_node("Sample")
	get_node("Center/ExplosionHolder").set_hidden(true)
	set_fixed_process(true)
	self.set_meta("estructura", 0)
	self.set_meta("enemigo", 1)

func _fixed_process(delta):
	if((sectors <=0) && !bossmode ):
		global.root.find_node("HPBoss",true,false).set_hidden(false)
		print("bossmode on")
		get_node("BossMusic").play_loop(90)
		get_parent().get_node("BGMusic").set_paused(true)
		bossmode = true
		get_node("Center/BossExtendedHitbox").queue_free()
		timer = get_node("BossTimer")
		timer.set_wait_time(phasetime)
		timer.connect("timeout",self,"_nextphase")
		timer.start()
	if(bossmode):
		global.root.find_node("HPBoss",true,false).set_val(hp*100/maxhp)
		playerpos = global.root.find_node("Player",true,false).get_pos()
		actualcd -= delta
		_rampage()
	if((hp <= 0) && !dead):
		dead = true
		_die()

func _rampage():
	if(attackmode == 0):
		enemycd= 1
		_patron0()
	if(attackmode == 1):
		enemycd = 0
		_patron1()
	if(attackmode == 2):
		enemycd= 0.15
		_patron2()
	if(attackmode == 3):
		enemycd= 0.1
		_patron3()
	if(attackmode == 4):
		enemycd= 1.5
		_patron4()
	if(attackmode == 5):
		enemycd= 0.25
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

func _die():
	sampler.play("Explosion")
	sampler.play("Explosion")
	sampler.play("Explosion")
	sampler.play("Explosion")
	get_node("BossMusic").set_paused(true)
	get_parent().victory()
	global.root.find_node("HPBoss",true,false).set_hidden(true)
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
	get_parent().next_level()
	queue_free()

func _patron0():#circulo
	if(actualcd <= 0):
		for n in range(18):
			_firerot(variation+(n*20))
		actualcd = enemycd #reinicia el CD
		variation+= 10

func _patron1():#apuntando al jugador
	if(actualcd <= 0):
		_fireat(playerpos)
		actualcd = enemycd #reinicia el CD

func _patron2():#el molinillo
	if(actualcd <= 0):
		for n in range(4):
			_firerot((variation+n)*90)
		actualcd = enemycd #reinicia el CD
		variation+= 0.075
func _patron3():#disparos aleatorios
	if(actualcd <= 0):
		_firerot(variation)
		actualcd = enemycd #reinicia el CD
		variation = randi()%360

func _patron4():#disparo que cubre 90grados
	if(actualcd <= 0):
		for n in range(30):
			_firerot((variation+n*3))
		actualcd = enemycd #reinicia el CD
		variation+= (randi()%4 * 90)

func _patron5(): #disparos haciendo como una X que se cierra
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
	laser.dmg = dmg
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
	laser.dmg = dmg
	laser_holder.add_child(laser)
	