
extends Node2D
var firetimer
var resttimer
var chargetimer
var rottimer
var timer
var s1
var s2
var s3
var sm
var dead = false
var maxhp = 150
var hp = maxhp
var sampler
var charging = false
var resting = false
var shooting = false
var rottime = 3
var chargetime = 2
var shottime = 2.5
var resttime = 5
var rotspeed = 0
var step = 0 #0 = rotacion, 1 = carga, 2= disparo, 3 = rest
var attack =0 #0 = medio libre, 1=disparar a destiempo,2=esquina a esquina,3=cruz

func _ready():
	self.set_hidden(true)
	s1 = get_node("Sector")
	s2 = get_node("Sector1")
	s3 = get_node("Sector2")
	sm = get_node("SectorM")
	sampler = get_node("Sample")
	firetimer = get_node("Timer")
	resttimer = get_node("Timer1")
	chargetimer = get_node("Timer2")
	rottimer = get_node("Timer3")

func start():
	global.root.find_node("HPBoss",true,false).set_hidden(false)
	s1.active = true
	s2.active = true
	s3.active = true
	sm.active = true
	s1.get_node("Hitbox").set_trigger(false)
	s2.get_node("Hitbox").set_trigger(false)
	s3.get_node("Hitbox").set_trigger(false)
	sm.get_node("Hitbox").set_trigger(false)
	set_fixed_process(true)
	_rotation()

func _fixed_process(delta):
	if(hp == 0 && !dead):
		_die()
	global.root.find_node("HPBoss",true,false).set_val(hp*100/maxhp)
	if(step == 0 && !dead):
		charging = false
		if(rotspeed < 360):
			rotspeed = rotspeed + delta*360
		self.rotate(deg2rad(rotspeed*delta))
	elif(rotspeed >0):
		rotspeed = rotspeed -delta*360
	if(step == 1 && !dead && !charging):
		charging= true
		self.rotate(deg2rad(rotspeed*delta))
		sm.get_node("Attack").set_frame(0)
		sm.get_node("Attack").play("default")
		s1.charge(attack)
		s2.charge(attack)
		s3.charge(attack)
		sm.charge(attack)
	elif(step == 2 && !dead && !shooting):
		s1.fire()
		s2.fire()
		s3.fire()
		sm.fire()
		shooting = true
	elif(step == 3 && !dead && !resting):
		s1.rest()
		s2.rest()
		s3.rest()
		sm.rest()
		resting = true

func _rotation():
	resting = false
	step = 0
	sm.get_node("Rest").set_hidden(true)
	sm.get_node("Attack").set_hidden(false)
	sm.get_node("Attack").set_frame(0)
	rottimer.set_wait_time(rottime)
	rottimer.connect("timeout",self,"_charge")
	rottimer.start()
	resttimer.stop()
func _charge():
	step = 1
	sm.get_node("Attack").set_frame(0)
	sm.get_node("Attack").play("default")
	attack = randi()%4
	chargetimer.set_wait_time(chargetime)
	chargetimer.connect("timeout",self,"_fire")
	chargetimer.start()
	rottimer.stop()
func _fire():
	charging = false
	step = 2
	firetimer.set_wait_time(shottime)
	firetimer.connect("timeout",self,"_rest")
	firetimer.start()
	chargetimer.stop()
func _rest():
	step = 3
	sm.get_node("Attack").set_hidden(true)
	sm.get_node("Rest").set_hidden(false)
	sm.get_node("Rest").set_frame(0)
	sm.get_node("Rest").play("default")
	resttimer.set_wait_time(resttime)
	resttimer.connect("timeout",self,"_rotation")
	resttimer.start()
	firetimer.stop()
	shooting = false

func _on_DamageArea_body_enter( body ):
	if(body.has_method("_hit") && body.has_meta("aliado")&& step == 3):
		body._hit(self)

func _die():
	dead = true
	if(global.sound):
		sampler.play("Explosion")
		sampler.play("Explosion")
		sampler.play("Explosion")
		sampler.play("Explosion")
	global.root.find_node("HPBoss",true,false).set_hidden(true)
	if global.music:
		get_parent().get_node("VictoryMusic").play_loop(11)
	global.wasplaying = get_parent().get_node("VictoryMusic")
	get_parent().get_node("BossMusic").stop()
	timer = get_node("Timer")
	timer.set_wait_time(5)
	timer.connect("timeout",self,"_timeout")
	timer.start()
	get_node("ExplosionHolder").set_hidden(false)
	for N in get_node("ExplosionHolder").get_children():
		if(N.has_method("play")):
			N.set_frame(0)
			N.play("default")

func _timeout():
	get_parent().victory()
	queue_free()