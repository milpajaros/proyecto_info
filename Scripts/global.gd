extends Node

var root
var current_scene = null

func _ready():
	root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )

func goto_scene(path):
	current_scene.queue_free()
	call_deferred("_deferred_goto_scene",path)

func _deferred_goto_scene(path):
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	root.add_child(current_scene)