extends CharacterBody2D


# How fast the player will move (pixels/sec).
@export var SPEED = 100

var directionDegrees = 0.0;

# Size of the game window.
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# Set velocity based on input and speed
	if input_direction.length() > 0:
		velocity.x = input_direction.x * SPEED
		velocity.y = input_direction.y * SPEED
		# Play the "run" or "walk" animation and potentially flip the sprite
		directionDegrees  = rad_to_deg(input_direction.angle())
		var directionName = convertDegreesToDirection(directionDegrees)
		$AnimatedSprite2D.play("walk_"+directionName)
		
		# Flip the sprite to face the correct direction (for side-scrollers)
	else:
		# If no input, set velocity to zero and play "idle" animation
		velocity = Vector2.ZERO
		var directionName = convertDegreesToDirection(directionDegrees)
		$AnimatedSprite2D.play("idle_"+directionName)
	# Move the character using built-in physics function
	move_and_slide()



func convertDegreesToDirection(degrees):
	var direction = "down";
	if degrees >= 30 && degrees < 165:
		direction = "down";
	elif degrees >= 165 && degrees < 200:
		direction = "left"
	elif degrees >= -135 && degrees < -90:
		direction = "up"
	elif degrees >= 350 || degrees < 30:
		direction = "right"
	return direction;
