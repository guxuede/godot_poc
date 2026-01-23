class_name Player extends CharacterBody2D


# How fast the player will move (pixels/sec).
@export var SPEED:int = 100
@export var ACCELERATION:float = SPEED/0.2
@export var eventHandleEnable: bool = true
@export var bodyTexture: Texture2D
@export var weaponTexture: int = 0;

var directionAngle = 0.0;
var lastGetHurtPosition:Vector2 = Vector2.ZERO


func _ready():
	print(self)
	$HitBox.Damaged.connect(takeDamage)

func _physics_process(delta: float) -> void:
	var dir = Vector2.from_angle(directionAngle).normalized()
	$AnimationTree.set("parameters/Idle/blend_position", dir)
	$AnimationTree.set("parameters/Walk/blend_position", dir)
	$AnimationTree.set("parameters/Spellcast/blend_position", dir)
	$AnimationTree.set("parameters/Slash/blend_position", dir)
	$AnimationTree.set("parameters/Slash1/blend_position", dir)
	$AnimationTree.set("parameters/Shot/blend_position", dir)
	$AnimationTree.set("parameters/Water/blend_position", dir)
	$AnimationTree.set("parameters/Hurt/blend_position", dir)

func faceToMouse():
	directionAngle =global_position.direction_to(get_global_mouse_position()).angle()

func moveAndFaceToDirrection(dir:Vector2, delta: float):
	velocity.x = move_toward(velocity.x, dir.x * SPEED, ACCELERATION*delta)
	velocity.y = move_toward(velocity.y, dir.y * SPEED, ACCELERATION*delta)
	directionAngle  = dir.angle()
	move_and_slide()

func moveBackAndFromLastHurtPosition(delta: float):
	print(lastGetHurtPosition,global_position)
	var dir = lastGetHurtPosition.direction_to(global_position)
	velocity.x = move_toward(velocity.x, dir.x * SPEED, ACCELERATION*delta)
	velocity.y = move_toward(velocity.y, dir.y * SPEED, ACCELERATION*delta)
	directionAngle  = (dir*-1).angle()
	move_and_slide()

func playSkill():
	print("playSkill")
	var fire_ball_tscn = preload("res://fire_ball.tscn")
	var fireBall = fire_ball_tscn.instantiate()
	fireBall.directionAngle = directionAngle

	var direction = Vector2.from_angle(fireBall.directionAngle) *50

	fireBall.position.x = position.x +  direction.x
	fireBall.position.y = position.y +  direction.y
	get_parent().add_child(fireBall)

func playSlashSkill():
	print("slash")

	pass


func convertDegreesToDirection(angle):
	var direction_id = int(round(angle / TAU * 4))
	var direction = "down";
	if direction_id == 1:
		direction = "down";
	elif direction_id == 2 or direction_id== -2:
		direction = "left"
	elif direction_id == -1:
		direction = "up"
	elif direction_id == 0:
		direction = "right"
	return direction;
	

func takeDamage(_damage:int, hitPostion:Vector2) -> void:
	lastGetHurtPosition = hitPostion
	$StateMachine.state.finished.emit("Hurt")
	print("take damage", _damage)
