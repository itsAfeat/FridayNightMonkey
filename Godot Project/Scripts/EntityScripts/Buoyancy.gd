extends RigidBody

onready var water_node = get_parent().get_node("Wasser")
onready var water_mat  = water_node.mesh.surface_get_material(0)

var time = 10.0

var _WAVE_SPEED = 0
var _WAVE_SIZE  = 0
var _HEIGHT     = 0

func _ready():
	_WAVE_SPEED = water_mat.get_shader_param("_WAVE_SPEED")
	_WAVE_SIZE = water_mat.get_shader_param("_WAVE_SIZE")
	_HEIGHT = water_mat.get_shader_param("_HEIGHT")
	
	set_process(true)


func calculate_height(x, y):
	var _t = time * _WAVE_SPEED
	var uv = Vector2(x, y) * _WAVE_SIZE
	
	var d1 = fmod(uv.x + uv.y, 2.0*PI)
	var d2 = fmod((uv.x + uv.y + 0.25) * 1.3, 6.0*PI)
	
	d1 = _t * 0.07 + d1;
	d2 = _t * 0.5 + d2;
	
	var dist = Vector2(
		sin(d1) * 0.15 + sin(d2) * 0.05,
		cos(d1) * 0.15 + cos(d2) * 0.05
	)
	
	return dist.y * _HEIGHT


func _process(delta):
	time += delta
	water_mat.set_shader_param("_TIME", time)
	
	#var x = self.translation.x
	#var y = self.translation.y
	#var z = self.translation.z
	
	#y += calculate_height(x, y)
	#var target_pos = Vector3(x, y, z)
	#self.global_transform.origin = target_pos
