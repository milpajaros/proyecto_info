
extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_fixed_process(true)

func _on_Area_body_enter( body ):
	if(body.has_method("_hit")):
		body._hit()
		print("Muerooooo")
		hide()
		queue_free()