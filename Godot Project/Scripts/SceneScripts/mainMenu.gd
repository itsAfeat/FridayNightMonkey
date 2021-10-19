extends Control

func _ready():
# warning-ignore:return_value_discarded
	$CenterContainer/VBoxContainer/StartBtn.connect("button_up", self, "_start_game")
# warning-ignore:return_value_discarded
	$CenterContainer/VBoxContainer/SettingsBtn.connect("button_up", self, "_settings_menu")
# warning-ignore:return_value_discarded
	$CenterContainer/VBoxContainer/ExitBtn.connect("button_up", self, "_exit_game")
	
func _start_game():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/testScene.tscn")

func _settings_menu():
	print("Not working yet")


func _exit_game():
	get_tree().quit()
