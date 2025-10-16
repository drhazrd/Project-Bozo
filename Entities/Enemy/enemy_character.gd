extends CharacterBody3D

@export var move_speed: float = 6.0

var enemy_material: Material

@onready var player_character: CharacterBody3D = $"../../Player Character"
@onready var enemy_mesh: MeshInstance3D = $Root/Skeleton3D/characterLargeMale
@onready var enemy_texture: Mesh = enemy_mesh.mesh
@onready var ap: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	enemy_mesh.set_surface_override_material(0, enemy_material)

func _physics_process(delta: float) -> void:
	if not is_instance_valid(player_character):
		return

	var direction = (player_character.global_position - global_position)
	direction.y = 0.0
	direction = direction.normalized()

	look_at(player_character.global_position, Vector3.UP)

	velocity = direction * move_speed
	move_and_slide()
	animation_handler()
	
func animation_handler():
	if velocity != Vector3.ZERO:
		ap.play("run/Root|Run")
