extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready():
	$HitBox.Damaged.connect(takeDamage)

#func _physics_process(delta: float) -> void:
	#pass


func takeDamage(_damage:int) -> void:
	print("Ourch...")
