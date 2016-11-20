
extends StreamPlayer

var time
var t

func _ready():
	var time =0

func play_loop(tim):
	t = tim
	self.play()
	set_process(true)
	time = t
	
func _process(delta):
	time = time -delta
	if(time <=0):
		self.stop()
		self.play_loop(t)