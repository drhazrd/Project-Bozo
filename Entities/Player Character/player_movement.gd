extends CharacterBody3D

@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var camera_3d: Camera3D = $"../Camera Controller/Camera3D"
var isAttacking = false
@onready var attackCooldown = 0.25

const SPEED = 10.0
const JUMP_VELOCITY = 4.5
const TURN_SPEED = 8.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("attackbutton") and canAttack():
		Attack()
		

	var input_dir := Input.get_vector("left", "right", "up", "down")
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
func Attack():
	isAttacking = true
	ap.play("attack/Root|Attack")
	print("Attack!")
	await ap.animation_finished
	await get_tree().create_timer(attackCooldown).timeout
	isAttacking = false
	
func canAttack():
	var attackStatus:bool = !isAttacking
	
	return attackStatus
	
func animation_handler():
	if is_on_floor() and velocity == Vector3.ZERO and isAttacking == false:
		ap.play("idle/Root|Idle")
	elif not is_on_floor():
		ap.play("jump/Root|Jump")
	elif velocity != Vector3.ZERO and is_on_floor():
		ap.play("walk/Root|Walk")
