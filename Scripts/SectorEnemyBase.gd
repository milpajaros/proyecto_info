extends KinematicBody2D

onready var enemy_scene = preload("res://scenes/enemy.xml")
var RotSpeed = 200
var timer
var nwave= 3
var maxhp = 50
var hp = maxhp
var dead = false

func _ready():
	get_node("ExplosionHolder").set_hidden(true)
	timer = get_node("EnemySpawnPoint/EnemySpawnrate")
	timer.set_wait_time(5)
	timer.connect("timeout",self, "_timeout")
	timer.start()
	set_process(true)
	
func _process(delta):
	get_node("Hpholder/HP").set_val(hp*100/maxhp)
	get_node("Hpholder").set_rot(-get_rot())
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
		enemy.set_pos(get_node("EnemySpawnPoint").get_global_pos())
		timer.set_wait_time(1)
		timer.start()
		nwave -=1
		get_node("EnemySpawnPoint/EnemyHolder").add_child(enemy)
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
	get_node("DamageArea").queue_free()
	timer = get_node("ExplosionHolder/ExplosionTimer")
	timer.set_wait_time(3)
	timer.connect("timeout",self,"_explosiontimeout")
	timer.start()
	get_node("ExplosionHolder").set_hidden(false)
	for N in get_node("ExplosionHolder").get_children():
		if(N.has_method("play")):
			N.set_frame(0)
			N.play("default")
	for N in get_node("EnemySpawnPoint/EnemyHolder").get_children():
		N._die()

func _explosiontimeout():
	get_parent().sectors -= 1
	hide()
	queue_free()