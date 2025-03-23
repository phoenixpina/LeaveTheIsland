extends Area2D

@export var message: String = "Default message!"  # Custom message per trigger
@export var textbox_scene: PackedScene  # Assign your Textbox scene in the Inspector

var textbox_instance

func _ready():
	connect("body_entered", _on_body_entered)  # Connects the trigger event

func _on_body_entered(body):
	if body.name == "Player":  # Ensure it's the player
		if not textbox_instance:
			textbox_instance = textbox_scene.instantiate()
			get_tree().current_scene.add_child(textbox_instance)
		textbox_instance.show_message(message)
