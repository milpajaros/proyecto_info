
extends KinematicBody2D
var laser = preload("res://scenes/laser.xml")
var lasercount=0
var laserArray = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	set_fixed_process(true)

func _fixed_process(delta):
	pass



 

func fire():
    lasercount+=1

    var laser_instance = laser.instance()
    
    laser_instance.set_name("laser"+str(lasercount))
    add_child(laser_instance)
    var laserpos = get_node("laser"+str(lasercount)).get_pos()
    var shippos = get_parent().get_node("Player").get_pos()
    laserpos.x = shippos.x
    laserpos.y = shippos.y
    
    get_node("laser"+str(lasercount)).set_pos(laserpos)
    laserArray.push_back("laser"+str(lasercount))
    