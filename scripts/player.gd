extends CharacterBody3D

@export var speed := 14
@export var fall_acceleration := 75
@export var jump_velocity := 15
@export var mouse_sensitivity := 0.002

#var target_velocity := Vector3.ZERO
var pitch := 0.0

@onready var ray_cast_3d := $Pivot/Camera3D/RayCast3D
@onready var pivot := $Pivot
@onready var camera_3d := $Pivot/Camera3D

func _ready() -> void:
	velocity = GameData.player.position
	add_to_group("can_use_doors", true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pivot.rotate_y(-event.relative.x * mouse_sensitivity)

		pitch = clamp(pitch - event.relative.y * mouse_sensitivity, deg_to_rad(-89), deg_to_rad(89))
		camera_3d.rotation.x = pitch

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
		
		direction = pivot.global_transform.basis * direction
		direction.y = 0

	GameData.player.position.x = direction.x * speed
	GameData.player.position.z = direction.z * speed

	if not is_on_floor():
		GameData.player.position.y -= fall_acceleration * delta
	else:
		GameData.player.position.y = 0
		if Input.is_action_pressed("jump"):
			GameData.player.position.y = jump_velocity

	velocity = GameData.player.position
	
	if Input.is_action_just_pressed("inntract"):
		if ray_cast_3d.is_colliding():
			if ray_cast_3d.get_collider().has_method("destroy_tile"):
				ray_cast_3d.get_collider().destroy_tile(ray_cast_3d.get_collision_point() - ray_cast_3d.get_collision_normal())

	move_and_slide()
