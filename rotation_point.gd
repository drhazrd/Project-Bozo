extends Node3D

@onready var character_large_male: CharacterBody3D = $"../characterLargeMale"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = character_large_male.position
