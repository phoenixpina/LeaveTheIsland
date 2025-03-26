extends Area2D

@export var move_distance: float = 100  # How far the enemy moves
@export var speed: float = 2.0  # Time it takes to move from point A to B
@export var enemy_sprite: Texture  # Allows setting different sprites in the Inspector
@export var move_vertical: bool = false  # If true, moves up/down instead of left/right


var start_position: Vector2
var target_position: Vector2
var moving_forward: bool = true

func _ready():
	start_position = global_position
	#target_position = start_position + Vector2(move_distance, 0)
	
	# Set target position based on movement type
	if move_vertical:
		target_position = start_position + Vector2(0, move_distance)  # Move up/down
	else:
		target_position = start_position + Vector2(move_distance, 0)  # Move left/right
	if enemy_sprite:
		$Sprite2D.texture = enemy_sprite 
	move_enemy()

func move_enemy():
	var tween = create_tween()  # Create a tween dynamically
	tween.tween_property(self, "global_position", target_position, speed).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(_on_tween_finished)  # Call this when the tween is done

func _on_tween_finished():
	moving_forward = !moving_forward  # Flip direction
	#target_position = start_position if moving_forward else start_position + Vector2(move_distance, 0)
	
	# Reverse movement based on movement type
	if move_vertical:
		target_position = start_position if moving_forward else start_position + Vector2(0, move_distance)
	else:
		target_position = start_position if moving_forward else start_position + Vector2(move_distance, 0)
	move_enemy()  # Move again in the opposite direction
	
func adjust_sprite_size():
	var sprite = $Sprite2D  # Get the sprite node
	var collision_shape = $CollisionShape2D  # Get the hitbox
	if enemy_sprite:  # If a custom sprite is assigned
		sprite.texture = enemy_sprite  # Apply the new sprite
		
		# Scale the sprite to match the original size
		var original_size = Vector2(64, 64)  # Replace with your original sprite's size
		var new_size = sprite.texture.get_size()
		if new_size.x > 0 and new_size.y > 0:  # Avoid division by zero
			sprite.scale = original_size / new_size  # Adjust scale to match the original size

			# Adjust the hitbox to match the resized sprite
			if collision_shape.shape is RectangleShape2D:
				collision_shape.shape.size = original_size  # Resize hitbox to match original




func _on_body_entered(body):
	if body.is_in_group("player"):  # If the player touches the enemy
		body.respawn()  # Teleport them to the checkpoint
