
extends Sprite

var damage = 2
var active = false
func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	for body in get_node("Area2D").get_overlapping_bodies():
		if (body.has_meta("aliado") && body.has_meta("nave")):
			body.hp = body.hp - damage

func _on_Area2D_body_enter( body ):
	if (body.has_meta("aliado") && body.has_meta("nave") && active):
		body.hp = 0
