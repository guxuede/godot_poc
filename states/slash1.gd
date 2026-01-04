class_name Slash1 extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	print("slash enter")
	player.faceToMouse()

func _on_animation_fire():
	player.playSlashSkill()

func _on_animation_done():
	finished.emit(IDLE)
