
extends Node

var timer
onready var enemy_scene = preload("res://scenes/enemy.xml")
var enemy
var enemynode

func _ready():
	timer = get_node("EnemySpawnPoint/EnemySpawnrate")
	timer.set_wait_time(4)
	timer.connect("timeout",self, "_timeout")
	timer.start()
	enemynode = get_node("EnemySpawnPoint")
	set_fixed_process(true)

func _timeout():
	enemy= enemy_scene.instance()
	var enemypos=enemy.get_global_pos()

	var enemyholder = get_node("EnemySpawnPoint/EnemyHolder")
	enemyholder.add_child(enemy)
	enemy.set_pos(enemypos)
	#es infinito hay que ponerle condicion de parada 
	timer.set_wait_time(4)
	timer.start()