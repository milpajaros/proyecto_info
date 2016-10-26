extends Node2D

var timer
onready var enemy_scene = preload("res://scenes/enemy.xml")



func _ready():
	timer = get_node("EnemySpawnPoint/EnemySpawnrate")
	timer.set_wait_time(4)
	timer.connect("timeout",self, "_timeout")
	timer.start()
	set_fixed_process(true)

func _timeout():
	enemy= enemy_scene.instance()
	var enemypos=enemy.get_global_pos()

	var enemyholder = get_node("EnemySpawnPoint/EnemyHolder")
	enemyholder.add_child(enemy)
	enemy.set_pos(get_node("EnemySpawnPoint").get_pos())
	timer.set_wait_time(4)
	timer.start()