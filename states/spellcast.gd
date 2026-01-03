class_name Spellcast extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	player.faceToMouse()

func _on_animation_fire():
	player.playSkill()

func _on_animation_done():
	finished.emit(IDLE)
