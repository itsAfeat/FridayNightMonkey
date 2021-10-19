extends Control

# warning-ignore:unused_argument
func _input(event):
	var new_pause_state = not get_tree().paused
	if event.is_action_pressed("ui_pause"):
			get_tree().paused = new_pause_state
			visible = new_pause_state
			
			if len(Input.get_connected_joypads()) == 0:
				if get_tree().paused:
					Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				else:
					Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
