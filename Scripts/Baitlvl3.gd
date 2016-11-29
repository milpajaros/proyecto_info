
extends StaticBody2D
onready var enemy_scene = preload("res://Scenes/Enemy.xml")
onready var bomber_scene = preload("res://Scenes/bomber.xml")
onready var laser_scene = preload("res://Scenes/laser_scene.xml")
var laserenemigo = preload("res://Textures/laserRed.png")
var timer
var actualcd = 0
var enemycd = 2
var maxhp= 100
var hp = maxhp
var dead = false
var bulletTTL = 1.5
var variation = 0
var dmg = 1
var sampler
var nwave

func _ready():
	nwave = 5
	set_process(true)
	timer = get_node("Timer")
	timer.set_wait_time(10)
	timer.connect("timeout",self,"_nextwave")
	timer.start()
	sampler = get_node("Sample")
	get_node("ExplosionHolder").set_hidden(true)

func _on_BulletHitbox_body_enter( body ):
	if(body.has_method("_hit") && body.has_meta("aliado")):
		body._hit(self)

func _process(delta):
	global.root.find_node("HPBoss",true,false).set_hidden(false)
	global.root.find_node("HPBoss",true,false).set_val(hp*100/maxhp)
	actualcd = actualcd- delta
	if(actualcd <= 0 && !dead):
		_fire()
		if(hp < 25):
			enemycd = 0.5
		elif(hp <= 50):
			enemycd = 1
		elif(hp <= 75):
			enemycd = 1.5
		else:
			enemycd = 2
		actualcd = enemycd
	if (dead== false) && (hp <=0):
		dead = true
		_die()

func _nextwave():
	if (nwave > 0):
		var enemy
		if (nwave == 1):
			enemy= bomber_scene.instance()
		else:
			enemy= enemy_scene.instance()
		var x = randi()%2000 -1000
		var y = randi()%2000 -1000
		enemy.chasedistance = 10000
		enemy.set_pos(Vector2(x,y))
		get_node("EnemyHolder").add_child(enemy)
		timer.set_wait_time(0.5)
		timer.start()
		nwave = nwave-1
	else:
		timer.set_wait_time(10)
		timer.start()
		nwave = 5

func _fire():
	for n in range(9):
		var rotation = (variation+(n*40))
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
	variation+= 5

func _die():
	if(global.sound):
		sampler.play("Explosion")
		sampler.play("Explosion")
		sampler.play("Explosion")
		sampler.play("Explosion")
	global.root.find_node("HPBoss",true,false).set_hidden(true)
	if global.music:
		get_parent().get_node("VictoryMusic").play_loop(11)
	get_parent().get_node("BGMusic").stop()
	timer = get_node("Timer")
	timer.set_wait_time(5)
	timer.connect("timeout",self,"_timeout")
	timer.start()
	get_node("ExplosionHolder").set_hidden(false)
	for N in get_node("ExplosionHolder").get_children():
		if(N.has_method("play")):
			N.set_frame(0)
			N.play("default")
	for N in get_node("EnemyHolder").get_children():
		N._die()

func _timeout():
	get_parent().get_node("Diamante").set_hidden(false)
	queue_free()
	