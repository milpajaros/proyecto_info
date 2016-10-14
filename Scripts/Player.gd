extends KinematicBody2D

<<<<<<< HEAD
var acceleration = 4000
var maxspeed = 400
var velocity = Vector2()
=======
# member variables here, example:

var laser = preload("res://scenes/laser.xml")
var lasercount=0

var acceleration = 4000
var maxspeed = 400
var velocity = Vector2()
var slowspeed= 0


>>>>>>> origin/master
func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
<<<<<<< HEAD
	var mousepos = get_global_mouse_pos()
	look_at(mousepos)
	
	if(Input.is_action_pressed("ui_left")):
		if(velocity.x > -maxspeed):
			velocity.x -= delta*acceleration
	if(Input.is_action_pressed("ui_right")):
		if(velocity.x < maxspeed):
			velocity.x += delta*acceleration
	if(Input.is_action_pressed("ui_up")):
		if(velocity.y > -maxspeed):
			velocity.y -= delta*acceleration
	if(Input.is_action_pressed("ui_down")):
		if(velocity.y < maxspeed):
			velocity.y += delta*acceleration

	if(!Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right")):
		velocity.x=0
	if(!Input.is_action_pressed("ui_up") && !Input.is_action_pressed("ui_down")):
		velocity.y=0        
	
	var movement = velocity*delta
	movement =move(movement)
	if (is_colliding()):
		var n = get_collision_normal()
		movement = n.slide(movement)
		velocity = n.slide(velocity)
		move(movement)
=======


    var mousepos = get_global_mouse_pos()
    look_at(mousepos)
    if (Input.is_action_pressed("ui_fire")):
        get_parent().get_node("laser").fire()
    if(Input.is_action_pressed("ui_left")):
        if(velocity.x > -maxspeed):
            velocity.x -= delta*acceleration
    if(Input.is_action_pressed("ui_right")):
        if(velocity.x < maxspeed):
            velocity.x += delta*acceleration
    if(Input.is_action_pressed("ui_up")):
        if(velocity.y > -maxspeed):
            velocity.y -= delta*acceleration
    if(Input.is_action_pressed("ui_down")):
        if(velocity.y < maxspeed):
            velocity.y += delta*acceleration
#Deseleracion
    if(!Input.is_action_pressed("ui_left") && (velocity.x !=slowspeed) && !Input.is_action_pressed("ui_right")):
       
         if (velocity.x>0):
            if (velocity.x - (delta*acceleration) <0):
                velocity.x=0
            else:       
                velocity.x -= (delta*acceleration)
         else:
            if (velocity.x + (delta*acceleration) <0):
                velocity.x=0
            else:       
                velocity.x += (delta*acceleration)

    if(!Input.is_action_pressed("ui_up") && (velocity.y !=slowspeed)&& !Input.is_action_pressed("ui_down")):
       
        if (velocity.y>0):
            if (velocity.y - (delta*acceleration) <0):
                velocity.y=0
            else:       
                velocity.y -= (delta*acceleration)
        else:
            if (velocity.y + (delta*acceleration) <0):
                velocity.y=0
            else:       
                velocity.y += (delta*acceleration)
            
    


    var movement = velocity*delta
    move(movement)

>>>>>>> origin/master
