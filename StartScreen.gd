extends Control

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER:
		get_tree().change_scene_to_file("res://Game.tscn")  # Change to your game scene path
