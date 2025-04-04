extends Area2D

@export var message: String = "Default message!"  
@export var textbox_scene: PackedScene 

var textbox_instance = null

func _ready():
	connect("body_entered", _on_body_entered)  

func _on_body_entered(body):
	if body.name == "Player": 
		if not textbox_instance:
			textbox_instance = textbox_scene.instantiate()
			get_tree().current_scene.add_child(textbox_instance)

		print("Trigger activated! Sending message:", message)  # Debug print
		textbox_instance.show_message(message)  
