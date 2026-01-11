class_name Walk extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	pass


func physics_update(delta: float) -> void:
	if Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_RIGHT):
		$"../../NavigationAgent2D".target_position = player.get_global_mouse_position()

	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# Set velocity based on input and speed
	if input_direction.length() > 0:
		#clear player navigation
		if not $"../../NavigationAgent2D".is_navigation_finished():
			$"../../NavigationAgent2D".target_position = player.position
		player.moveAndFaceToDirrection(input_direction, delta)
		# Flip the sprite to face the correct direction (for side-scrollers)
	elif not $"../../NavigationAgent2D".is_navigation_finished():
		var navDir = player.to_local($"../../NavigationAgent2D".get_next_path_position()).normalized()
		print("move with Navigation", player.position, navDir)
		player.moveAndFaceToDirrection(navDir, delta)
	else:
		finished.emit(IDLE)
