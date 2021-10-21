extends AnimatedSprite

var enemies_in_range = []

func _process(_delta):
	if Input.is_action_pressed("ui_attack") and not playing:
		if len(enemies_in_range) > 0:
			for enemy in enemies_in_range:
				enemy.take_damage()
		play()


func _on_Weapon_animation_finished():
	frame = 0
	stop()

func _on_Area_body_entered(body):
	if body.is_in_group("Enemy"):
		enemies_in_range.append(body)

func _on_Area_body_exited(body):
	if body in enemies_in_range:
		var index = enemies_in_range.find(body)
		enemies_in_range.remove(index)
