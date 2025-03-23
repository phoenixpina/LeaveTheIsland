extends CanvasLayer

#@onready var text_label = $ColorRect/Label
@onready var text_label = $CanvasLayer/Textbox
#was textbox

# Function to show the textbox with a message
func show_message(message: String) -> void:
	text_label.text = message
	visible = true
	$Timer.start(5)  # Hide after 5 seconds

# Hide when the timer runs out
#func _on_Timer_timeout():
#	visible = false


func _on_timer_timeout() -> void:
	visible = false
