extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var acceleration = 4000
var maxspeed = 400
var velocity = Vector2()
var slowspeed= 0
func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    set_fixed_process(true)

func _fixed_process(delta):
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