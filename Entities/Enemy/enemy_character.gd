extends CharacterBody3D

@export var move_speed: float = 3.0

@onready var player_character: CharacterBody3D = $"../../Player Character"

func _physics_process(delta: float) -> void:
	if not is_instance_valid(player_character):
		return

	var direction = (player_character.global_position - global_position)
	direction.y = 0.0
	direction = direction.normalized()

	look_at(player_character.global_position, Vector3.UP)

	# Move toward the player
	velocity = direction * move_speed
	move_and_slide()
