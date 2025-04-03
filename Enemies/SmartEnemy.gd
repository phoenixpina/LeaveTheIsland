extends CharacterBody2D  # CharacterBody2D supports movement

@export var speed: float = 50.0  # Speed of the enemy
@export var detection_radius: float = 200.0  # How far the enemy detects the player

var player: Node2D = null  # Reference to the player

func _ready():
	# Set the detection radius dynamically
	$DetectionArea/CollisionShape2D.shape.radius = detection_radius  

func _process(delta):
	if player:  # If the player is detected, move toward them
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):  # Detect if the player enters range
		player = body  

func _on_detection_area_body_exited(body):
	if body == player:  # Stop following if player leaves range
		player = null  
