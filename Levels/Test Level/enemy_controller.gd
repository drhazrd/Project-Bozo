extends Node3D

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 3.0
@export var min_spawn_distance: float = 20.0
@export var max_spawn_distance: float = 60.0
@export var max_enemies: int = 100
@export var enemy_materials: Array[Material] = []


@onready var player: CharacterBody3D = $"../Player Character"
var enemies: Array = []


@onready var spawn_timer: Timer = $SpawnTimer

func _ready() -> void:
	spawn_timer.wait_time = spawn_interval
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	enemies = enemies.filter(func(e): return is_instance_valid(e))
	if enemies.size() >= max_enemies:
		return
	var angle = randf_range(0.0, TAU)
	var distance = randf_range(min_spawn_distance, max_spawn_distance)
	var offset = Vector3(cos(angle), 0, sin(angle)) * distance
	var spawn_pos = player.global_position + offset
	var enemy = enemy_scene.instantiate()
	var material = enemy_materials.pick_random().duplicate()
	enemy.global_position = spawn_pos
	enemy.enemy_material = material
	add_child(enemy)
	enemies.append(enemy)
