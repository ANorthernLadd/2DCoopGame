extends KinematicBody2D

onready var player = get_node("res://Player/Player.tscn")
const UP = Vector2(0, -1)
const GRAVITY = 20
export var ACCELERATION = 50
export var MAX_SPEED = 50
export var JUMP_HEIGHT = -600
var motion = Vector2()

func _physics_process(delta):
	motion.x = MAX_SPEED
	$AnimatedSprite.play("Run")
	motion.y += GRAVITY
	
	if motion.x < 0:
			$AnimatedSprite.play("Run")
			$AnimatedSprite.flip_h = true;
	
		
	
	motion = move_and_slide(motion, UP)
