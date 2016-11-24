
extends Sprite

var rot=0

func _ready():
	set_process(true)

func _process(delta):
	rot = rot +delta*90
	self.set_rot(deg2rad(rot))