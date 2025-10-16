extends Control

@export var player: CharacterBody3D
@onready var healthcomponent = player.get_node("Components/HealthComponent")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$"Bottom Left/Label".text = str(healthcomponent.health)
