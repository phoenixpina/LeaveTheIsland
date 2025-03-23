extends Area2D

@export var next_scene: PackedScene  # Scene to load when player enters

func _on_body_entered(body):
	if body.is_in_group("player") and next_scene:
		get_tree().change_scene_to_packed(next_scene)  # Just change the scene!
