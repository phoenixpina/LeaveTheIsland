extends Area2D

@export var message: String = "Hello, welcome!"  # Set custom text in Inspector
@onready var text_box = $"../CanvasLayer/ColorRect"  # Adjust if needed

func _on_body_entered(body):
	print("Detected: ", body.name)  # Debugging print
	if body.name == "Player":
		text_box.show_message(message)

func _process(delta):
	for body in get_overlapping_bodies():
		print("Overlapping: ", body.name)
