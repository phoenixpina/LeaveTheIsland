extends Area2D

@export var move_distance: float = 100  
@export var speed: float = 2.0  # Time it takes to move from point A to B
@export var enemy_sprite: Texture  
@export var move_vertical: bool = false  # If true, moves up/down instead of left/right


var start_position: Vector2
var target_position: Vector2
var moving_forward: bool = true

func _ready():
	start_position = global_position

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
	
	# Reverse movement based on movement type
	if move_vertical:
		target_position = start_position if moving_forward else start_position + Vector2(0, move_distance)
	else:
		target_position = start_position if moving_forward else start_position + Vector2(move_distance, 0)
	move_enemy()  # Move again in the opposite direction
	
func adjust_sprite_size():
	var sprite = $Sprite2D  
	var collision_shape = $CollisionShape2D  
	if enemy_sprite:  # If a custom sprite is assigned, applies new sprite
		sprite.texture = enemy_sprite  
		
		# Scales the sprite to match the original size
		var original_size = Vector2(64, 64) 
		var new_size = sprite.texture.get_size()
		if new_size.x > 0 and new_size.y > 0: 
			sprite.scale = original_size / new_size 

			# Adjusts the hitbox to match the resized sprite
			if collision_shape.shape is RectangleShape2D:
				collision_shape.shape.size = original_size  




func _on_body_entered(body):
	if body.is_in_group("player"): 
		body.respawn()  # Teleports player to checkpoint on collision
