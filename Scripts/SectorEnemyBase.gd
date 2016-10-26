extends KinematicBody2D

onready var enemy_scene = preload("res://scenes/enemy.xml")
var RotSpeed = 100
var timer
var nwave= 3
var hp = 100
var dead = false

func _ready():
	get_node("ExplosionHolder").set_hidden(true)
	timer = get_node("EnemySpawnPoint/EnemySpawnrate")
	timer.set_wait_time(5)
	timer.connect("timeout",self, "_timeout")
	timer.start()
	set_process(true)
	
func _process(delta):
	look_at(get_parent().get_pos())
	if(get_pos().distance_to(get_parent().get_node("Center").get_pos()) < 250):
		move_local_y(-delta)
	if(get_pos().distance_to(get_parent().get_node("Center").get_pos()) > 250):
		move_local_y(delta)
	move_local_x(RotSpeed*delta)
	if(hp <= 0):
		if(!dead):
			dead = true
			_die()

func _timeout():
	if(nwave> 0):
		var enemy= enemy_scene.instance()
		get_node("EnemySpawnPoint/EnemyHolder").add_child(enemy)
		enemy.set_pos(get_node("EnemySpawnPoint").get_global_pos())
		timer.set_wait_time(1)
		timer.start()
		nwave -=1
	else:
		timer.set_wait_time(15)
		timer.start()
		nwave = 3

func _on_DamageArea_body_enter( body ):
	if(body.has_method("_hit") && body.has_meta("aliado")):
		body._hit(self)
	if(body.has_method("_hit") && body.has_meta("enemigo")):
		body._timeout()

func _die():
	hp = 0
	get_parent().sectors -= 1
	timer = get_node("ExplosionHolder/ExplosionTimer")
	timer.set_wait_time(3)
	timer.connect("timeout",self,"_explosiontimeout")
	timer.start()
	get_node("ExplosionHolder").set_hidden(false)
	for N in get_node("ExplosionHolder").get_children():
		if(N.has_method("play")):
			N.set_frame(0)
			N.play("default")

func _explosiontimeout():
	hide()
	queue_free()