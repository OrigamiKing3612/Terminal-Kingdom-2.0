extends Node

@export var player: CharacterBody3D
@export var mesh: Node3D
@export var rotation_speed: float = 8
@export var fall_gravity: float = 45
var jump_gravity: float = fall_gravity
var jump_distance: float = 15
var direction: Vector3
var velocity: Vector3
var acceleration: float
var speed: float
var camera_rotation: float = 0
var player_init_rotation: float

func _ready():
	player_init_rotation = player.rotation.y

func _physics_process(delta: float) -> void:
	velocity.x = speed * direction.normalized().x
	velocity.z = speed * direction.normalized().z
	
	if not player.is_on_floor():
		if velocity.y >= 0:
			velocity.y -= jump_gravity * delta
		else:
			velocity.y -= fall_gravity * delta
	
	player.velocity = player.velocity.lerp(velocity, acceleration * delta)
	GameManager.player.position = player.global_position
	player.move_and_slide()
	
	var target_rotation = atan2(direction.x, direction.z) - player_init_rotation
	mesh.rotation.y = lerp_angle(mesh.rotation.y, target_rotation, rotation_speed * delta)

func _jump():
	velocity.y = jump_distance

func _on_set_movement_state(_movement_state: MovementState):
	speed = _movement_state.movement_speed
	acceleration =  _movement_state.acceleration

func _on_set_movement_direction(_movement_direction: Vector3):
	direction = _movement_direction.rotated(Vector3.UP, camera_rotation + player_init_rotation)

func _on_set_camera_rotation(_camera_rotation: float):
	camera_rotation = _camera_rotation
