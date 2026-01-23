class_name Hurt extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	pass


func physics_update(delta: float) -> void:
	player.moveBackAndFromLastHurtPosition(delta)



func _on_animation_fire():
	pass

func _on_animation_done():
	finished.emit(IDLE)
