# PlayerAttack.gd
extends Node

@onready var ap: AnimationPlayer = $"../AnimationPlayer" # reference from parent

var melee_cooldown := 0.5
var ranged_cooldown := 0.75
var shield_duration := 3.0
var can_melee := true
var can_ranged := true
var shield_active := false

signal shield_activated
signal shield_deactivated

func melee_attack():
	if not can_melee:
		return

	can_melee = false
	ap.play("attack/Root|Attack")
	print("Melee attack!")
	await get_tree().create_timer(melee_cooldown).timeout
	can_melee = true

func ranged_attack():
	if not can_ranged:
		return

	can_ranged = false
	ap.play("ranged/Root|Shoot")
	print("Ranged attack!")
	_spawn_projectile()
	await get_tree().create_timer(ranged_cooldown).timeout
	can_ranged = true

func activate_shield():
	if shield_active:
		return

	shield_active = true
	print("Shield activated!")
	emit_signal("shield_activated")
	await get_tree().create_timer(shield_duration).timeout
	shield_active = false
	print("Shield deactivated.")
	emit_signal("shield_deactivated")

func _spawn_projectile():
	# Replace with your projectile scene
	#var projectile_scene = preload("res://Entities/WeaponsFolder/Projectile.tscn")
	#var projectile = projectile_scene.instantiate()
	print("Fure!")
	# Position the projectile at the player's location
	#projectile.global_transform.origin = $"../".global_transform.origin + Vector3(0, 1.5, 0)
	#projectile.look_at(projectile.global_transform.origin + $"../".global_transform.basis.z)
	
	#get_tree().current_scene.add_child(projectile)
