extends Control

var playerHealth = 3
var rng = RandomNumberGenerator.new()

var full_health_img = load("res://Textures/HEALTH/Sprite_UI_Liv_Fuldt.png")
var halv_health_img = load("res://Textures/HEALTH/Sprite_UI_Liv_Halvt.png")

var hurt1_img = load("res://Textures/HEALTH/Sprite_UI_AV.png")
var hurt2_img = load("res://Textures/HEALTH/Sprite_UI_BANG.png")
var hurt_imgs = [ hurt1_img,
				  hurt2_img ]

onready var healthNode = get_node("Health")
onready var hurtNode = get_node("HurtImg")
onready var timer = get_parent().get_parent().get_node("Timer")

var timerStarted = false

func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")

func take_damage():
	if not timerStarted:
		playerHealth -= 1
	
		if playerHealth == 2:
			healthNode.texture = halv_health_img
		if playerHealth == 1:
			healthNode.texture = null
		if playerHealth <= 0:
			# warning-ignore:return_value_discarded
			playerHealth = 3
			healthNode.texture = halv_health_img
			get_tree().change_scene(get_tree().current_scene.filename)
		
		rng.randomize()
		var rand_num = rng.randi_range(0, 1)
		hurtNode.texture = hurt_imgs[rand_num]
	
		timer.start(1.5)
		timerStarted = true
	
func _on_timer_timeout():
	hurtNode.texture = null
	timerStarted = false
