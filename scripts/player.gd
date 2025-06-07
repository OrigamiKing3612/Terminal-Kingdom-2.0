extends CharacterBody3D

@export var speed = 14
@export var fall_acceleration = 75
@export var jump_velocity = 15

var target_velocity = Vector3.ZERO

func _ready() -> void:
	add_to_group("can_use_doors", true)

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 0.5
	if Input.is_action_pressed("move_left"):
		direction.x -= 0.5
	if Input.is_action_pressed("move_back"):
		direction.z += 0.5
	if Input.is_action_pressed("move_forward"):
		direction.z -= 0.5
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction)
	
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	else:
		target_velocity.y = 0
		if Input.is_action_just_pressed("jump"):
			target_velocity.y = jump_velocity


	velocity = target_velocity
	move_and_slide()
