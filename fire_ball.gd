extends CharacterBody2D


# How fast the player will move (pixels/sec).
@export var SPEED = 100.0
@export var ACCELERATION = SPEED/0.2
@export var directionAngle = 0

var isDead = false

func _ready():
	$AnimatedSprite2D.animation_finished.connect(_on_dead_animation_finished)

func _physics_process(delta):
	if not isDead:
		var input_direction = Vector2.from_angle(directionAngle)
		velocity.x = move_toward(velocity.x, input_direction.x * SPEED, ACCELERATION*delta)
		velocity.y = move_toward(velocity.y, input_direction.y * SPEED, ACCELERATION*delta)
		## Play the "run" or "walk" animation and potentially flip the sprite
		directionAngle  = input_direction.angle()
		$AnimatedSprite2D.rotation = directionAngle
		$AnimatedSprite2D.play("default")
		move_and_slide()
#
		var conllisionCount = get_slide_collision_count();
		for i in conllisionCount:
			var collision_info = get_slide_collision(i)
			var collider = collision_info.get_collider()
			print("collider:", collider)
			collider.queue_free()
		if conllisionCount > 0:
			velocity = Vector2.ZERO
			isDead = true
			$AnimatedSprite2D.play("dead")


func _on_dead_animation_finished():
	self.queue_free()
