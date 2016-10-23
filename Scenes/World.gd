
extends Node

var timer
onready var enemy_scene = preload("res://scenes/enemy.xml")
var enemy

func _ready():
	timer = get_node("Enemy_1_spawnrate")
	timer.set_wait_time(4)
	timer.connect("timeout",self, "_timeout")
	timer.start()
	set_fixed_process(true)
func _fixed_process(delta):
	
	pass
	
	
	
	
	
func _timeout():
	enemy= enemy_scene.instance()
	var enemypos=get_node("Enemy/Enemy_spawn_point").get_global_pos()
	var enemyholder = get_node("Enemy_1_holder")
	enemyholder.add_child(enemy)
	enemy.set_pos(enemypos)
	#es infinito hay que ponerle condicion de parada 
	timer.set_wait_time(4)
	timer.connect("timeout",self, "_timeout")
	timer.start()

	




