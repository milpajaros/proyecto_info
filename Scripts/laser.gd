
extends KinematicBody2D
var laser = preload("res://scenes/laser.xml")
var lasercount=0
var laserArray = []
var mousearray = []
var vectorArray =[]



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here

	
	set_fixed_process(true)

func _fixed_process(delta):
	var x=0
	for laser in laserArray:
		var laserpos = get_pos()
		vectorArray.push_back((mousearray[x] -laserpos).normalized())
		move(vectorArray[x]*100*delta)
		print("laser pos",x, laserpos)
		print("mouse pos",x,mousearray[x])
		print("vector ",x,vectorArray[x])
		x+=1
		
	
		#necesito que cada hijo tenga la variable inherente a el vector y mouse pos




 

func fire():
    lasercount+=1

    var laser_instance = laser.instance()
    
    laser_instance.set_name("laser"+str(lasercount))
    add_child(laser_instance)
    mousearray.push_back(get_local_mouse_pos())
    laser_instance.set_rot(get_global_mouse_pos().angle_to_point(get_parent().get_node("Player").get_pos()))
    var laserpos = get_node("laser"+str(lasercount)).get_pos()
    var shippos = get_parent().get_node("Player").get_global_transform().get_origin()
    
    laserpos.x = shippos.x
    laserpos.y = shippos.y
    
    get_node("laser"+str(lasercount)).set_pos(laserpos)
    laserArray.push_back("laser"+str(lasercount))
    