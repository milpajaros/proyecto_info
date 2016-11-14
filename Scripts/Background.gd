
extends ParallaxBackground

var offloc = 0

func _ready():
	set_process(true)
	
func _process(delta):
	offloc = offloc +50*delta
	set_scroll_offset(Vector2(offloc,offloc))