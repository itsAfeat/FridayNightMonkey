extends RayCast

func _ready():
	set_process(true)
	
func _process(_delta):
	if is_colliding():
		var body = self.get_collider()
		print(body.get_name())
