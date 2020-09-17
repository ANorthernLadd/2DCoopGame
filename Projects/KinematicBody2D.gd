extends KinematicBody2D

const UP = Vector2(0, -1)
export var GRAVITY = 20
export var ACCELERATION = 50
export var MAX_SPEED = 200
export var STOP = 0
export var JUMP_HEIGHT = -600
var attacking = false
var motion = Vector2()
onready var animationPlayer = $AnimationPlayer

func _physics_process(_delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$"Sprite".flip_h = false;
		if !attacking:
			animationPlayer.play("RUN")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$"Sprite".flip_h = true;
		if !attacking:
			animationPlayer.play("RUN")
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		friction = true
		if !attacking:
			animationPlayer.play("IDLE")
			
	if Input.is_action_pressed("ui_down"):
		motion.x = STOP
		if !attacking:
			animationPlayer.play("CROUCH")

	var jumping = checkAndHandleJump(friction)
#	HandleAttack(jumping)

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
			animationPlayer.play("JUMP")
		else:
			animationPlayer.play("FALLING")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
	return jumping
	
#func HandleAttack(jumping):
#	if !jumping && Input.is_action_just_pressed("attack"):
#		$AnimatedSprite.play("Slash")
#		attacking = true
#	if $AnimatedSprite.get_frame() == 3 && attacking:
#		attacking = false
