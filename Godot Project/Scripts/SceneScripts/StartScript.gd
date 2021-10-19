extends Spatial

func _ready():
	var screen_size = OS.get_screen_size(0)
	var window_size = OS.get_window_size()
	
	OS.set_window_position(screen_size*0.5 - window_size*0.5)

func _process(_delta):
	OS.set_window_title("Monke | FPS: " + str(Engine.get_frames_per_second())
	+ " | Total Frames: " + str(Engine.get_frames_drawn()))
