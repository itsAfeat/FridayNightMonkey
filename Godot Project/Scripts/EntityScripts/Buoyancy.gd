extends Spatial

onready var water_node = get_tree().get_nodes_in_group("Water")[0]
onready var water_mat  = water_node.mesh.surface_get_material(0)
onready var ship_node = get_parent().get_parent()

var time = 0.0
var submerged_depth = 0.0
var floater_count = 6

var _WAVE_SIZE  = 0
var _HEIGHT     = 0

func _ready() -> void:
	print("WATER >>> ", water_node.name)
	print("SHIP >>> ", ship_node.name)
	set_process(true)


func wave(phase : float, speed : float, amplitude : float) -> float:
	return sin(time * speed + phase) * amplitude;


func get_height(position : Vector2) -> float:
	var wave_size = water_mat.get_shader_param("_WAVE_SIZE")
	var x = position.x * wave_size.x
	var y = position.y * wave_size.y
	# Angle each wave differently for interesting interactions
	var w1 = x + y * .1
	var w2 = x + y * .2
	var w3 = x + y
	# Use speeds and amplitudes which aren't easily refactorable
	var dist = wave(w1, .32, .40) + wave(w2, 0.5, 0.33) + wave(w3, .43, .27)
	return dist * water_mat.get_shader_param("_HEIGHT")


func apply_buoyancy(point : Vector3) -> void:
	var depth = get_height(Vector2(point.x, point.z)) - point.y
	if depth > submerged_depth:
		ship_node.add_central_force(Vector3(0, depth, 0))
		ship_node.add_force(Vector3(0, depth/100, 0), self.global_transform.origin)


func _process(delta) -> void:
	if not get_tree().paused:
		time += delta
		water_mat.set_shader_param("_TIME", time)
		apply_buoyancy(self.global_transform.origin)
