
extends ParallaxBackground

var offloc = 0
var down = false

func _ready():
	set_process(true)
	
func _process(delta):
	if(offloc > 1000):
		down = true
	if(offloc < 0):
		down = false
	if(down):
		offloc = offloc - 10*delta
	else:
		offloc = offloc + 10*delta
	set_offset(Vector2(-offloc,offloc))
func stop():
	set_process(false)