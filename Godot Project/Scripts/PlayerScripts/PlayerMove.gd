extends KinematicBody

const grav  = -24.8
var   vel   = Vector3()
var   dir   = Vector3()
var max_spd = 10
var accel   = 4.5

const jmp_spd   = 10
const deaccel   = 16
const max_slope = 40

var cam
var rot_help
var viewport

var mouse_sen = 0.15


func _ready():
	cam      = $RotHelp/Camera
	rot_help = $RotHelp
	#viewport = get_viewport().get_parent()
	#viewport.stretch_shrink = 3
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta):
	process_input(delta)
	process_movement(delta)


func process_input(_delta):
	dir = Vector3.ZERO
	
	var cam_xform = cam.global_transform
	var input_vector = Vector2()
	
	if Input.is_key_pressed(KEY_W):
		input_vector.y += 1
	if Input.is_key_pressed(KEY_S):
		input_vector.y -= 1
	if Input.is_key_pressed(KEY_D):
		input_vector.x += 1
	if Input.is_key_pressed(KEY_A):
		input_vector.x -= 1
	
	if Input.is_key_pressed(KEY_SHIFT):
		accel   = 4.5
		max_spd = 10
	else:
		accel   = 4
		max_spd = 7.4
		
	input_vector = input_vector.normalized()
	dir += -cam_xform.basis.z * input_vector.y
	dir += cam_xform.basis.x * input_vector.x
	
	if is_on_floor():
		if Input.is_key_pressed(KEY_SPACE):
			vel.y = jmp_spd
	
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_tree().quit(0)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func process_movement(delta):
	dir.y = 0
	dir   = dir.normalized()
	
	vel.y += delta * grav
	
	var hvel = vel
	hvel.y   = 0
	
	var target = dir
	target    *= max_spd
	
	var ACCEL
	if dir.dot(hvel) > 0:
		ACCEL = accel
	else:
		ACCEL = deaccel
		
	hvel  = hvel.linear_interpolate(target, ACCEL * delta)
	vel.x = hvel.x
	vel.z = hvel.z
	vel = move_and_slide(vel, Vector3(0, 1, 0), 0.05, 4, deg2rad(max_slope))


func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rot_help.rotate_x(deg2rad(event.relative.y * mouse_sen * -1))
		self.rotate_y(deg2rad(event.relative.x * mouse_sen * -1))
		
		var cam_rot = rot_help.rotation_degrees
		cam_rot.x   = clamp(cam_rot.x, -70, 70)
		rot_help.rotation_degrees = cam_rot
