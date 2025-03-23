extends Area2D

@export var new_texture: Texture2D  # Assign this in the Inspector

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):  
		var sprite = body.get_node("Sprite2D")  
		if sprite:
			var old_texture_size = sprite.texture.get_size()  # Get old texture size
			sprite.texture = new_texture  # Change texture
			var new_texture_size = sprite.texture.get_size()  # Get new texture size
			
			if new_texture_size != Vector2.ZERO:  # Avoid division by zero
				sprite.scale *= old_texture_size / new_texture_size  # Adjust scale
