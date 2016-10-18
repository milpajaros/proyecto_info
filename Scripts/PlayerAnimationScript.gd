
extends AnimatedSprite

# member variables here, example:
# var a=2
# var b="textvar"
var tempElapsed=0

func _ready():
	set_process(true)
	
func _process(delta):
	tempElapsed =tempElapsed +delta
	
	if(!Input.is_action_pressed("ui_up") && !Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right") && !Input.is_action_pressed("ui_down")):
		set_frame(0)
	else:
		if(tempElapsed > 0.1):
			if(get_frame() == get_sprite_frames().get_frame_count("default")-1):
				set_frame(2)
			else:
				set_frame(get_frame()+1)
			tempElapsed=0