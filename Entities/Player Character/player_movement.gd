extends CharacterBody3D

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var camera_3d: Camera3D = $"../Camera Controller/Camera3D"


const SPEED = 10.0
const JUMP_VELOCITY = 4.5
const TURN_SPEED = 8.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (camera_3d.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction.length() > 0:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		var target_yaw = atan2(direction.x, direction.z)
		rotation.y = lerp_angle(rotation.y, target_yaw, TURN_SPEED * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	animation_handler()

func animation_handler():
	if is_on_floor() and velocity == Vector3.ZERO:
		ap.play("idle/Root|Idle")
	elif not is_on_floor():
		ap.play("jump/Root|Jump")
	elif velocity != Vector3.ZERO and is_on_floor():
		ap.play("walk/Root|Walk")
