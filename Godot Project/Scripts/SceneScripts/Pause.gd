extends Control

var controller_connected = false

var continueCoords = Vector2(542.0, 261.0)
var settingsCoords = Vector2(542.0, 321.0)
var menuCoords = Vector2(542.0, 377.0)
var quitCoords = Vector2(532.0, 439.0)

onready var doodleNode = get_node("DoodleCircle")

onready var continueButton = get_node("ContinueButton")
onready var settingsButton = get_node("SettingsButton")
onready var menuButton = get_node("MenuButton")
onready var quitButton = get_node("QuitButton")

var continue_selected = load("res://Textures/PAUSE/Sprite_UI_Menu_Continue_Selected.png")
var settings_selected = load("res://Textures/PAUSE/Sprite_UI_Menu_Settings_Selected.png")
var menu_selected = load("res://Textures/PAUSE/Sprite_UI_Menu_MainMenu_Selected.png")
var quit_selected = load("res://Textures/PAUSE/Sprite_UI_Menu_Quit_Selected.png")

var continue_unselected = load("res://Textures/PAUSE/Sprite_UI_Menu_Continue_Unselected.png")
var settings_unselected = load("res://Textures/PAUSE/Sprite_UI_Menu_Settings_Unselected.png")
var menu_unselected = load("res://Textures/PAUSE/Sprite_UI_Menu_MainMenu_Unselected.png")
var quit_unselected = load("res://Textures/PAUSE/Sprite_UI_Menu_Quit_Unselected.png")

onready var buttons = [ continueButton,
						settingsButton,
						menuButton,
						quitButton ]
var selected_btns = [ continue_selected,
						settings_selected,
						menu_selected,
						quit_selected ]
var unselected_btns = [ continue_unselected,
						settings_unselected,
						menu_unselected,
						quit_unselected ]
						
var selectedButton = 0
var using_mouse = false

func _ready():
	continueButton.connect("mouse_entered", self, "focus_continue")
	settingsButton.connect("mouse_entered", self, "focus_settings")
	menuButton.connect("mouse_entered", self, "focus_menu")
	quitButton.connect("mouse_entered", self, "focus_quit")
	
	continueButton.connect("mouse_exited", self, "unfocus_all")
	settingsButton.connect("mouse_exited", self, "unfocus_all")
	menuButton.connect("mouse_exited", self, "unfocus_all")
	quitButton.connect("mouse_exited", self, "unfocus_all")
	
	continueButton.connect("pressed", self, "continue_clicked")
	settingsButton.connect("pressed", self, "settings_clicked")
	menuButton.connect("pressed", self, "menu_clicked")
	quitButton.connect("pressed", self, "quit_clicked")
	
	doodleNode.playing = true

func _input(event):
	if event == InputEventMouseMotion:
		controller_connected = false
		using_mouse = true
	if event == InputEventJoypadMotion || event == InputEventJoypadButton:
		controller_connected = true
		
	var new_pause_state = not get_tree().paused
	if event.is_action_pressed("ui_pause"):
			get_tree().paused = new_pause_state
			visible = new_pause_state
	
func _process(_delta):
	if using_mouse:
		if get_tree().paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if not using_mouse:
		if get_tree().paused:
			if Input.is_action_just_pressed("ui_down"):
				if (selectedButton + 1) > len(buttons)-1:
					selectedButton = 0
				else:
					selectedButton += 1
			if Input.is_action_just_pressed("ui_up"):
				if (selectedButton - 1) < 0:
					selectedButton = len(buttons)-1
				else:
					selectedButton -= 1
			if Input.is_action_just_pressed("ui_accept"):				
				var btn = buttons[selectedButton]
				
				if btn == continueButton:
					continue_clicked()
				elif btn == settingsButton:
					settins_clicked()
				elif btn == menuButton:
					menu_clicked()
				elif btn == quitButton:
					quit_clicked()
				
			var btn = buttons[selectedButton]
			unfocus_all()

			if btn == continueButton:
				focus_continue()
			elif btn == settingsButton:
				focus_settings()
			elif btn == menuButton:
				focus_menu()
			elif btn == quitButton:
				focus_quit()
			
func focus_continue():
	selectedButton = 0
	continueButton.get_child(0).texture = continue_selected
	doodleNode.visible = true
	doodleNode.position = continueCoords

func focus_settings():
	selectedButton = 1
	settingsButton.get_child(0).texture = settings_selected
	doodleNode.visible = true
	doodleNode.position = settingsCoords

func focus_menu():
	selectedButton = 2
	menuButton.get_child(0).texture = menu_selected
	doodleNode.visible = true
	doodleNode.position = menuCoords
	
func focus_quit():
	selectedButton = 3
	quitButton.get_child(0).texture = quit_selected
	doodleNode.visible = true
	doodleNode.position = quitCoords

func unfocus_all():
	var i = 0
	for btn in buttons:
		btn.get_child(0).texture = unselected_btns[i]
		i += 1
		
	doodleNode.visible = false


func continue_clicked():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	
func settins_clicked():
	pass
	
func menu_clicked():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
# warning-ignore:return_value_discarded
	get_tree().change_scene(get_tree().current_scene.filename)
	
func quit_clicked():
	get_tree().quit(0)
