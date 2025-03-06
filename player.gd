extends CharacterBody2D

const SPEED = 200  # Movement speed in pixels per second

func _process(delta):
	var direction = Vector2.ZERO  # Default to no movement

	# Check for input and set direction
	if Input.is_action_pressed("Right"):
		direction.x += 1
	if Input.is_action_pressed("Left"):
		direction.x -= 1
	if Input.is_action_pressed("Down"):
		direction.y += 1
	if Input.is_action_pressed("Up"):
		direction.y -= 1

	# Normalize to avoid faster diagonal movement
	if direction.length() > 0:
		direction = direction.normalized()

	# Move the character
	velocity = direction * SPEED
	move_and_slide()
