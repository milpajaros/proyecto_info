
var multiplicador = 1
onready var boss_scene = preload("res://Scenes/Boss.xml")
var stage = 1
var scorepanel
var multipler 
var player
var boss

func _ready():
	global.score = 0
	scorepanel = global.root.find_node("Score", true, false)
	multipler = global.root.find_node("Multipler", true, false)
	player = global.root.find_node("Player", true, false)
	change_pos()
	scorepanel.set_hidden(false)
	global.arcade = true
	if global.music:
		get_node("BGMusic").play()
	
func increase_score(inc):
	global.score += inc * multiplicador * stage
	scorepanel.parse_bbcode(str(global.score))
	
func change_pos():
	boss = boss_scene.instance()
	var direction = randi() % 360
	direction = deg2rad(direction)
	var distance = 2000 + randi() % 2001
	var x = player.get_pos().x + sin(direction) * distance
	var y = player.get_pos().y + cos(direction) * distance
	boss.set_pos(Vector2(x,y))
	get_node("bossholder").add_child(boss)
	
func increase_mult(inc):
	multiplicador += inc
	multipler.parse_bbcode("X"+str(multiplicador))