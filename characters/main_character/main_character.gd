extends CharacterBody2D

@export var SPEED = 150
@export var JUMP_FORCE = 450
@export var GRAVITY = 900
@export var MAX_SPEED = 500

func _physics_process(delta):
	
	var direction = Input.get_axis("move_left","move_right")
	
	if direction and velocity.x < MAX_SPEED:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0
		

	#Rotate
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true

	#Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	#Jump
	if Input.is_action_just_pressed("action_jump") and is_on_floor():
		velocity.y -= JUMP_FORCE
		
	move_and_slide()
	
#animations
func _process(delta):
	if velocity.y < 0 and not is_on_floor():
		$AnimatedSprite2D.play("Jump")
	if velocity.y > 0 and not is_on_floor():
		$AnimatedSprite2D.play("Fall")
	if velocity.x != 0 and is_on_floor():
		$AnimatedSprite2D.play("Run")
	if velocity.x == 0 and is_on_floor():
		$AnimatedSprite2D.play("Idle")
	
