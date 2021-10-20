extends RigidBody

onready var ray = get_node("RayCast")

func _ready():
	ray.enabled = true
	set_process(true)

func _process(_delta):
	if ray.is_colliding():
		var body = ray.get_collider()
		print(body.get_name())
