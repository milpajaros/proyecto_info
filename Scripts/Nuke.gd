
extends KinematicBody2D

var pantalla = Vector2(100,100)
var prueba = Vector2(37,37)


func _ready():
	
	get_node("hitbox").set_scale(pantalla)
	get_node("hitbox").set_pos(prueba)
	get_node("Sprite").set_scale(pantalla)
	set_process(true)
	
func _process(delta):
	for body in get_node("hitbox").get_overlapping_bodies():
		if (!body.has_meta("aliado") && !body.has_meta("arma")&& body.has_method("_die")):
			_hit(body)



	
func _hit(body):
	body.hp=0



