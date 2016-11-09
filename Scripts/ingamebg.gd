
extends ParallaxBackground

var offloc = 0

func _ready():
	set_process(true)
	
func _process(delta):
	offloc = offloc +10*delta
	set_offset(Vector2(-offloc,offloc))