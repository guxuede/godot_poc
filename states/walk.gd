class_name Walk extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	pass


func physics_update(delta: float) -> void:
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# Set velocity based on input and speed
	if input_direction.length() > 0:
		player.velocity.x = move_toward(player.velocity.x, input_direction.x * player.SPEED, player.ACCELERATION*delta)
		player.velocity.y = move_toward(player.velocity.y, input_direction.y * player.SPEED, player.ACCELERATION*delta)
		# Play the "run" or "walk" animation and potentially flip the sprite
		player.directionAngle  = input_direction.angle()
		player.playAnimation("walk")
		player.move_and_slide()
		# Flip the sprite to face the correct direction (for side-scrollers)
	else:
		finished.emit(IDLE)
