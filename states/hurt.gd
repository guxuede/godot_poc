class_name Hurt extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	pass


func physics_update(delta: float) -> void:
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# Set velocity based on input and speed
	if input_direction.length() > 0:
		#clear player navigation
		
		player.moveAndFaceToDirrection(input_direction, delta)



func _on_animation_fire():
	pass

func _on_animation_done():
	finished.emit(IDLE)
