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

var checkpoint_position: Vector2  # The player's safe position

func _ready():
	add_to_group("player")
	checkpoint_position = global_position  # Set initial checkpoint
	check_for_spawn()

func respawn():
	global_position = checkpoint_position  # Teleport player back

func set_checkpoint(new_position: Vector2):
	checkpoint_position = new_position  # Update the respawn location

func check_for_spawn():
	var spawn_point = get_tree().current_scene.find_child("PlayerSpawn", true)
	if spawn_point:
		global_position = spawn_point.global_position  # Move player to spawn location
