extends Control

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER:
		get_tree().change_scene_to_file("res://Game.tscn")  # Changes to game scene path
