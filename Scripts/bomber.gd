extends KinematicBody2D
onready var bomb_scene = preload("res://Scenes/bomb_scene.xml")
var bombenemigo = preload("res://Textures/bomb.png")
#PONER UN SPRITE

var bomb
var enemycd = 5
var actualcd = 0
var DistanciaProxima = 200
var player
const SPEED = 300
var speed = SPEED
var maxhp =4
var hp = maxhp
var timer
var dead = false
var distancia
var playerpos
var carryingbomb= false
var chasedistance = 1000

func _ready():
	actualcd = 2
	get_node("ExplosionAnimation").set_hidden(true)
	set_fixed_process(true)
	set_meta("enemigo",1)
	set_meta("nave",2)


func _on_Area2D_body_enter( body ):
	if(body.has_method("_hit") && body.has_meta("aliado")):
		body._hit(self)

func _fixed_process(delta):
	player = global.root.find_node("Player", true, false)
	if((actualcd <0) && (get_node("bombsprite").is_hidden()) && !dead):
		carryingbomb = true
		get_node("bombsprite").set_hidden(false)
	if((actualcd>0) && (!get_node("bombsprite").is_hidden()) && !dead):
		carryingbomb = false
		get_node("bombsprite").set_hidden(true)
	get_node("Hpholder/HP").set_val(hp*100/maxhp)
	get_node("Hpholder").set_rot(-get_rot())
	actualcd -= delta
	distancia= get_pos().distance_to(player.get_pos())
	if(distancia < chasedistance && actualcd<0):
		_chase(delta)
	elif(distancia < 400 && actualcd >0):
		_runaway(delta)
	if(distancia <200):
		_fire()
	if(hp <= 0):
		if(!dead):
			dead = true
			_die()

func _fire():
	if(actualcd<=0 && !dead):
		actualcd = enemycd #reinicia el CD
		bomb = bomb_scene.instance()
		bomb.get_node("Sprite").set_texture(bombenemigo)
		var enemypos = get_pos()
		bomb.set_meta("enemigo",0)
		var bombSpawnPoint = get_pos()
		var bomb_holder = get_node("bombHolder")
		bomb.set_pos(bombSpawnPoint)
		bomb_holder.add_child(bomb)

func _chase(delta):
	if(!dead):
		look_at(player.get_pos())
		get_node("AnimatedSprite").set_rot(deg2rad(180))
	var movement = Vector2(player.get_pos().x-get_pos().x,player.get_pos().y-get_pos().y)
	movement = movement.normalized()
	
	movement = move(movement*delta*speed)
	if (is_colliding()):
		var n = get_collision_normal()
		movement = n.slide(movement)
		move(movement)

func _runaway(delta):
	if(!dead):
		look_at(player.get_pos())
		get_node("AnimatedSprite").set_rot(0)
	var movement = Vector2(get_pos().x-player.get_pos().x,get_pos().y-player.get_pos().y)
	movement = movement.normalized()
	
	movement = move(movement*delta*speed)
	if (is_colliding()):
		var n = get_collision_normal()
		movement = n.slide(movement)
		move(movement)

func _die():
	if(carryingbomb):
		bomb = bomb_scene.instance()
		bomb.get_node("Sprite").set_texture(bombenemigo)
		var enemypos = get_pos()
		bomb.set_meta("enemigo",0)
		var bombSpawnPoint = get_pos()
		bomb.set_pos(bombSpawnPoint)
		var bomb_holder = get_node("bombHolder")
		bomb_holder.add_child(bomb)
		find_node("bomb",true,false)._timeout()
	hp = 0
	get_node("Hpholder").set_hidden(true)
	dead = true
	speed = 0
	timer = get_node("Timer")
	timer.set_wait_time(0.5)
	timer.connect("timeout",self,"_timeout")
	timer.start()
	get_node("AnimatedSprite").set_hidden(true)
	get_node("bombsprite").set_hidden(true)
	get_node("ExplosionAnimation").set_hidden(false)
	get_node("ExplosionAnimation").set_frame(0)
	get_node("ExplosionAnimation").play("default")
	if(global.sound):
		get_node("Sample").play("Explosion")
	
func _timeout():
	hide()
	self.queue_free()