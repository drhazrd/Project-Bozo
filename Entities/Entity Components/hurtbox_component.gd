extends Area3D

signal hurt_enemy(enemy: Node)

func _ready() -> void:
	connect("body_entered", _on_body_entered)


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		emit_signal("hurt_enemy", body)
