extends KinematicBody2D
onready var bomb_scene = preload("res://scenes/bomb_scene.xml")
var bombenemigo = preload("res://Textures/bomb.png")
#PONER UN SPRITE

var bomb
var enemycd = 5
var actualcd = 0
var DistanciaProxima = 200
var player
const SPEED = 200
var speed = SPEED
var maxhp =5
var hp = maxhp
var timer
var dead = false
var distancia
var playerpos

func _ready():
	actualcd = 2
	get_node("ExplosionAnimation").set_hidden(true)
	set_fixed_process(true)
	player = get_tree().get_root().find_node("Player", true, false)



func _on_Area2D_body_enter( body ):
	if(body.has_method("_hit") && body.has_meta("aliado")):
		body._hit(self)

func _fixed_process(delta):
	get_node("Hpholder/HP").set_val(hp*100/maxhp)
	get_node("Hpholder").set_rot(-get_rot())
	actualcd -= delta
	distancia= get_pos().distance_to(player.get_pos())
	if(distancia < 1000):
		_chase(delta)
	if(distancia <500):
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
	var movement = Vector2(player.get_pos().x-get_pos().x,player.get_pos().y-get_pos().y)
	movement = movement.normalized()
	if(distancia < DistanciaProxima):
		var n = movement.tangent()
		movement = movement.slide(n)
	
	movement = move(movement*delta*speed)
	if (is_colliding()):
		var n = get_collision_normal()
		movement = n.slide(movement)
		move(movement)

func _die():
	hp = 0
	speed = 0
	timer = get_node("EnemyTimer")
	timer.set_wait_time(1)
	timer.connect("timeout",self,"_timeout")
	timer.start()
	get_node("EnemySprite").set_hidden(true)
	get_node("ExplosionAnimation").set_hidden(false)
	get_node("ExplosionAnimation").set_frame(0)
	get_node("ExplosionAnimation").play("default")
	
func _timeout():
	hide()
	self.queue_free()