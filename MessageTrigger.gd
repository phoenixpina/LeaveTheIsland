extends Area2D

@export var message: String = "Default message!"  # Allows custom messages
@export var textbox_scene: PackedScene  # Assign Textbox.tscn in Inspector

var textbox_instance = null

func _ready():
	connect("body_entered", _on_body_entered)  # Ensure the signal is connected

func _on_body_entered(body):
	if body.name == "Player":  # Ensure it's the player
		if not textbox_instance:
			textbox_instance = textbox_scene.instantiate()
			get_tree().current_scene.add_child(textbox_instance)

		print("Trigger activated! Sending message:", message)  # Debug print
		textbox_instance.show_message(message)  # ✅ Send the correct message
