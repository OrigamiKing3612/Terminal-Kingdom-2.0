extends CharacterBody3D

@export var speed = 14
@export var fall_acceleration = 75
@export var jump_velocity = 15
@export var mouse_sensitivity = 0.002

var target_velocity = Vector3.ZERO
var pitch := 0.0

func _ready() -> void:
	add_to_group("can_use_doors", true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Something just doesn't feel right
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		$Pivot.rotate_y(-event.relative.x * mouse_sensitivity)

		pitch = clamp(pitch - event.relative.y * mouse_sensitivity, deg_to_rad(-89), deg_to_rad(89))
		$Pivot/Camera3D.rotation.x = pitch

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		# Move relative to where the Pivot (head/body) is facing
		direction = $Pivot.global_transform.basis * direction
		direction.y = 0

	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	if not is_on_floor():
		target_velocity.y -= fall_acceleration * delta
	else:
		target_velocity.y = 0
		if Input.is_action_just_pressed("jump"):
			target_velocity.y = jump_velocity

	velocity = target_velocity
	move_and_slide()
