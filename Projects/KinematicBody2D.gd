extends KinematicBody2D

const UP = Vector2(0, -1)
export var GRAVITY = 20
export var ACCELERATION = 50
export var MAX_SPEED = 200
export var JUMP_HEIGHT = -600
var attacking = false
var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$AnimatedSprite.flip_h = false;
		if !attacking:
			$AnimatedSprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$AnimatedSprite.flip_h = true;
		if !attacking:
			$AnimatedSprite.play("Run")
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		friction = true
		if !attacking:
			$AnimatedSprite.play("Idle")

	var jumping = checkAndHandleJump(friction)
	HandleAttack(jumping)

	motion = move_and_slide(motion, UP)
	pass
	
func checkAndHandleJump(friction):
	var jumping = false
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			jumping = true
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)	
	else:
		jumping = true
		if motion.y < 0:
			$AnimatedSprite.play("Jump")
		else:
			$AnimatedSprite.play("Fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
	return jumping
	
func HandleAttack(jumping):
	if !jumping && Input.is_action_just_pressed("attack"):
		$AnimatedSprite.play("Slash")
		attacking = true
	if $AnimatedSprite.get_frame() == 3 && attacking:
		attacking = false
