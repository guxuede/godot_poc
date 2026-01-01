class_name Idle extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	player.velocity = Vector2.ZERO
	player.playAnimation("idle")


func physics_update(_delta: float) -> void:	
	if Input.is_action_just_pressed("ui_use_skill"):
		finished.emit(SPELLCAST)
	elif Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").length() > 0:
		finished.emit(WALK)
	elif Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT):
		finished.emit(SLASH)
	else :
		player.playAnimation("idle")
