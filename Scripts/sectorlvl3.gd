
extends KinematicBody2D
var beamtexture= preload("res://Textures/redbeam.png")
var blasttexture = preload("res://Textures/redblast.png")
var active = false
var beam
var resting = false
var beamrotation
var charging = false
var shooting = false
var mode =0
var scale = 0.1
var sampler
var dmg = 1

func _ready():
	beam = get_node("Beam")
	sampler = get_parent().get_node("Sample")
	set_fixed_process(true)
	
func charge(t):
	beam.active = true
	mode = t
	charging = true
	if global.sound:
		sampler.play("Charge")
	beam.set_texture(blasttexture)
	if(mode == 0):
		beam.set_rot(deg2rad(20))
	elif(mode == 1):
		beam.set_rot(deg2rad(-60))
	elif(mode == 2 || mode == 3):
		beam.set_rot(deg2rad(0))
		
	

func _fixed_process(delta):
	if(charging):
		if(scale <0.4):
			scale = scale+delta*0.8
		else:
			scale = 0.4
		beam.set_scale(Vector2(scale,(scale+0.2)))
	elif(shooting):
		if(mode == 0):
			beam.set_texture(beamtexture)
			beam.set_scale(Vector2(0.4, 12))
		elif(mode == 1):
			beam.rotate(deg2rad(delta*15))
			beam.set_texture(beamtexture)
			beam.set_scale(Vector2(0.4, 12))
		elif(mode == 2 || mode == 3):
			beam.rotate(deg2rad(-delta*8))
			beam.set_texture(beamtexture)
			beam.set_scale(Vector2(0.4, 12))
	else:
		beam.set_texture(blasttexture)
		beam.set_scale(Vector2(0.1, 0.1))
		beam.set_rot(deg2rad(0))

func fire():
	charging = false
	shooting = true
	if global.sound:
		sampler.play("BeamShot")
	
func rest():
	shooting =false
	beam.set_texture(blasttexture)
	beam.set_scale(Vector2(0.1, 0.1))
	beam.set_rot(deg2rad(0))
	
func _on_Area2D_body_enter( body ):
	if(body.has_method("_hit") && body.has_meta("aliado") && active):
		body._timeout()