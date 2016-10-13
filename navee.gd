extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var velx = 0
var vely = 0
var velmin = 100
var velxmax= 500
var velymax= 500
var acc = 50
func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    set_process(true)

func _process(delta):
    var mousepos = get_global_mouse_pos()
    look_at(mousepos)
    if(!Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right")):
        velx= velmin


    elif(Input.is_action_pressed("ui_left")):
        if (velx>-velxmax):
            if velx>0:
                velx=velx/2
            velx=velx-acc
        move(Vector2((velx)*delta,0))
    elif(Input.is_action_pressed("ui_right")):
        if (velx<velxmax):
            if velx<0:
	            velx=velx/2
            velx= velx + acc
        move(Vector2((velx)*delta,0))

    if(!Input.is_action_pressed("ui_up") && !Input.is_action_pressed("ui_down")):
        vely= velmin

    elif(Input.is_action_pressed("ui_up")):
        if (vely>-velymax):
            if vely>0:
                vely=vely/2
            vely=vely-acc
        move(Vector2(0,(vely)*delta))
    elif(Input.is_action_pressed("ui_down")):
        if (vely<velymax):
            if vely<0:
                vely=vely/2
            vely = vely + acc
        move(Vector2(0,(vely)*delta))
        