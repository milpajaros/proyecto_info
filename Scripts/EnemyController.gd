
extends KinematicBody2D
onready var laser_scene = preload("res://scenes/laser_scene.xml")
var laserenemigo = preload("res://Textures/laserRed.png")
# member variables here, example:
# var a=2
# var b="textvar"
var laser
var enemycd = 0.30
var actualcd = 0
func _ready():
	set_fixed_process(true)

func _on_Area_body_enter( body ):
	if(body.has_method("_hit") && body.has_meta("aliado")):
		body._hit()
		print("Muerooooo")
		hide()
		queue_free()
		
func _fixed_process(delta):
	actualcd -= delta
	look_at(get_parent().get_node("Player").get_pos())
	var distancia=get_pos().distance_to(get_parent().get_node("Player").get_pos())
	if((distancia < 1000) && (actualcd<=0 )):
		actualcd = enemycd #reinicia el CD
		laser = laser_scene.instance()
		laser.get_node("LaserSprite").set_texture(laserenemigo)
		var enemypos = get_pos()
		var LaserSpawnPoint = get_pos()
		var laser_holder = get_node("Laser_holder")
		laser_holder.add_child(laser)
		
		laser.set_pos(LaserSpawnPoint)
		laser.look_at(get_parent().get_node("Player").get_pos())