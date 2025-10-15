extends Node

@export var health_max: int = 100
@export var hurtbox_component: Node
var health: int

func _ready() -> void:
	health = health_max

func _on_hurtbox_component_body_entered(body: Node3D) -> void:
	health -= 1
