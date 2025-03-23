extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):  # Check if it's the player
		body.set_checkpoint(global_position)  # Update player's respawn location
