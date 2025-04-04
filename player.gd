extends CharacterBody2D

const SPEED = 400  # Movement speed in pixels per second

func _process(delta):
	var direction = Vector2.ZERO  # Makes it so player isn't moving without input

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

	velocity = direction * SPEED
	move_and_slide()

var checkpoint_position: Vector2 

func _ready():
	add_to_group("player")
	checkpoint_position = global_position  # Initial checkpoint
	check_for_spawn()

func respawn():
	global_position = checkpoint_position  

func set_checkpoint(new_position: Vector2):
	checkpoint_position = new_position  # Updates respawn location when checkpoints are touched

func check_for_spawn():
	var spawn_point = get_tree().current_scene.find_child("PlayerSpawn", true)
	if spawn_point:
		global_position = spawn_point.global_position 
