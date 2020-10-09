extends KinematicBody2D

const UP = Vector2(0, -1)
export var GRAVITY = 20
export var ACCELERATION = 50
export var MAX_SPEED = 200
export var CROUCH_SPEED = 100
export var STOP = 0
export var JUMP_HEIGHT = -600
var attacking = false
var motion = Vector2()
onready var animationPlayer = $AnimationPlayer
var currentState

enum STATE{
  RUNNING,
  CROUCH_WALKING,
  CROUCHING,
  IDLE,
  JUMPING,
  FALLING,
  ATTACKING
}

func _physics_process(_delta):
	applyGravity()
	getCurrentState()
	var maxspeed = getMaxSpeed()
	movePlayer(maxspeed)
	animate()
	motion = move_and_slide(motion, UP)
	pass

func getCurrentState():		
	if is_on_floor():
		var jumping = false
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			jumping = true
		if !jumping:
			if Input.is_action_just_pressed("attack"):
				currentState = STATE.ATTACKING
				attacking = true
				animationPlayer.connect("animation_finished", self, "stopAttack")
			if Input.is_action_pressed("ui_down"):
				if Input.is_action_pressed("ui_right"):
					currentState = STATE.CROUCH_WALKING
				elif Input.is_action_pressed("ui_left"):
					currentState = STATE.CROUCH_WALKING
				else:
					currentState = STATE.CROUCHING
			else:
				if Input.is_action_pressed("ui_right"):
					if !attacking:
						currentState = STATE.RUNNING
				elif Input.is_action_pressed("ui_left"):
					if !attacking:
						currentState = STATE.RUNNING
				else:
					if !attacking:
						currentState = STATE.IDLE				
	else:
		if motion.y < 0:
			currentState = STATE.JUMPING
		else:
			currentState = STATE.FALLING			
			
func animate():
	if currentState == STATE.JUMPING:
		animationPlayer.play("JUMP")
	elif currentState == STATE.CROUCH_WALKING:
		animationPlayer.play("CROUCH_WALK")
	elif currentState == STATE.CROUCHING:
		animationPlayer.play("CROUCH")
	elif currentState == STATE.RUNNING:
		animationPlayer.play("RUN")
	elif currentState == STATE.FALLING:
		animationPlayer.play("FALLING")	
	elif currentState == STATE.IDLE:
		animationPlayer.play("IDLE")
	elif currentState == STATE.ATTACKING:
		animationPlayer.play("ATTACK")
		
func applyGravity():
	motion.y += GRAVITY

func stopAttack(anim):
	attacking = false
	animationPlayer.disconnect("animation_finished", self, "stopAttack")

func movePlayer(max_speed):
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELERATION, max_speed)
		$"Sprite".flip_h = false;
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -max_speed)
		$"Sprite".flip_h = true;
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		
func getMaxSpeed():
	if currentState == STATE.CROUCHING || currentState == STATE.CROUCH_WALKING :
		return CROUCH_SPEED
	else:
		return MAX_SPEED
		
