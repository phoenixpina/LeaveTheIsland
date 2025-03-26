extends CanvasLayer

@onready var text_label = $ColorRect/text_label  # ✅ Make sure this matches your scene!
@onready var timer = $Timer

func _ready():
	visible = false  # Start hidden

func show_message(message: String) -> void:
	print("Showing message:", message)  # Debug print
	if text_label:
		text_label.text = message
		text_label.visible = false  # 🔄 Force refresh
		await get_tree().process_frame  # 🕒 Wait 1 frame
		text_label.visible = true  # ✅ Make visible again
		print("Updated text_label:", text_label.text)  # Check if it's updating
		var debug_font = text_label.get_theme_font("font")  # Get assigned font
		print("Font in use:", debug_font)  # Print font info
		visible = true
		timer.start(3)
	else:
		print("Error: text_label is null!")

func _on_Timer_timeout():
	visible = false


func _on_timer_timeout() -> void:
	visible = false 
	print("Textbox hidden")
