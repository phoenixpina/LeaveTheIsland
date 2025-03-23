extends Area2D

@export var move_distance: float = 100  # How far the enemy moves
@export var speed: float = 2.0  # Time it takes to move from point A to B
@export var enemy_sprite: Texture  # Allows setting different sprites in the Inspector


var start_position: Vector2
var target_position: Vector2
var moving_forward: bool = true

func _ready():
	start_position = global_position
	target_position = start_position + Vector2(move_distance, 0)
	if enemy_sprite:
		$Sprite2D.texture = enemy_sprite 
	move_enemy()

func move_enemy():
	var tween = create_tween()  # Create a tween dynamically
	tween.tween_property(self, "global_position", target_position, speed).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(_on_tween_finished)  # Call this when the tween is done

func _on_tween_finished():
	moving_forward = !moving_forward  # Flip direction
	target_position = start_position if moving_forward else start_position + Vector2(move_distance, 0)
	move_enemy()  # Move again in the opposite direction


func _on_body_entered(body):
	if body.is_in_group("player"):  # If the player touches the enemy
		body.respawn()  # Teleport them to the checkpoint
