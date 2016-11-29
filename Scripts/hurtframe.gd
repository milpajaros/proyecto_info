
extends TextureFrame

var opacity = 0.0

func _ready():
	set_opacity(opacity)
	set_process(true)
	
func _process(delta):
	if opacity > 0:
		set_opacity(opacity)
		opacity = opacity - delta*2
	else:
		set_opacity(0)

func get_hurt():
	opacity = 1

