extends Node2D

@onready var room_holder = $RoomHolder  # Holds the active room
@onready var player = $Player  # The player

func _ready():
	load_room("res://scenes/starting_room.tscn", "SpawnPoint")  # Load the first room

func load_room(room_path: String, spawn_marker_name: String):
	print("Loading new room:", room_path, "at marker:", spawn_marker_name)  # Debugging
	# Remove the current room
	for child in room_holder.get_children():
		child.queue_free()
	
	# Load and instance the new room
	var room = load(room_path).instantiate()
	room_holder.add_child(room)

	# Move the player to the correct spawn point
	var spawn_marker = room.get_node(spawn_marker_name) if room.has_node(spawn_marker_name) else null
	if spawn_marker:
		player.position = spawn_marker.position

	# Connect doors in the new room
	connect_doors()

func connect_doors():
	for door in room_holder.get_children():
		if door is Area2D:
			door.room_transition_requested.connect(load_room)
