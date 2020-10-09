extends KinematicBody2D

onready var player = get_node("res://Player/Player.tscn")
const UP = Vector2(0, -1)
const GRAVITY = 20
export var ACCELERATION = 50
export var MAX_SPEED = 50
export var JUMP_HEIGHT = -600
var motion = Vector2()
var horizontalMovementModifier = 1
export var rightside = false

func _physics_process(delta):
	var olddirection = rightside
	
	motion.x = MAX_SPEED * horizontalMovementModifier
	if isColliding():
		horizontalMovementModifier = horizontalMovementModifier * -1
	$AnimatedSprite.play("Run")
	motion.y += GRAVITY
	
	if motion.x < 0:
		rightside = true
		$AnimatedSprite.play("Run")
	elif motion.x > 0:
		rightside = false
		$AnimatedSprite.play("Run")
	else:
		$AnimatedSprite.play("Idle")
	if rightside != olddirection:
		self.scale.x *= -1
	
	motion = move_and_slide(motion, UP)

func isColliding():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if horizontalMovementModifier == 1 && collision.position.x > get_global_position().x + 5:
			return true
		if horizontalMovementModifier == -1 && collision.position.x < get_global_position().x - 5:
			return true
	return false
