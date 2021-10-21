extends KinematicBody

var health = 2
var taking_damage = false
var dead = false

onready var sprite = get_node("MonkeSprite")
onready var timer = get_node("Timer")

var frame_happy = 0
var frame_angry = 1
var frame_av1   = 2
var frame_av2   = 3
var frame_end   = 4

func take_damage():
	if not taking_damage:
		health -= 1
		taking_damage = true
		
		if health == 0:
			timer.start(0.75)
			sprite.animation = "explode"
			sprite.frame = 0
			sprite.play()
			dead = true
			
		if not dead:
			sprite.frame = frame_av1
			sprite.play()
		
func _process(_delta):
	if taking_damage and not dead:
		if sprite.frame == frame_end:
			taking_damage = false
			sprite.frame = 1
			sprite.stop()


func _on_Timer_timeout():
	queue_free()
