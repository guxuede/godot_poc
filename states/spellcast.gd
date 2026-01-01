class_name Spellcast extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	player.faceToMouse()
	player.playAnimation("spellcast")
	player.get_node("Body").animation_finished.connect(_on_spell_animation_finished)

#func physics_update(delta: float) -> void:
	#if not $AnimatedSprite2D.is_playing():
		#finished.emit(IDLE)


func _on_spell_animation_finished():
	player.get_node("Body").animation_finished.disconnect(_on_spell_animation_finished)
	player.playSkill()
	finished.emit(IDLE)
