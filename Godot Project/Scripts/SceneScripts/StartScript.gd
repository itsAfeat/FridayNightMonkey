extends Spatial

func _process(_delta):
	OS.set_window_title("Monke | FPS: " + str(Engine.get_frames_per_second())
	+ " | Total Frames: " + str(Engine.get_frames_drawn()))
