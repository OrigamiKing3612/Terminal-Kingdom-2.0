extends Node

@export var player: CharacterBody2D
@export var sprites: Node2D
@export var rotation_speed: float = 8
@export var fall_gravity: float = 45
var jump_gravity: float = fall_gravity
var jump_distance: float = 15
var direction: Vector2
var velocity: Vector2
var acceleration: float
var speed: float
var camera_rotation: float = 0
var player_init_rotation: float

func _ready():
	player_init_rotation = player.rotation

func _physics_process(delta: float) -> void:
	velocity = speed * direction.normalized()
	
	#if not player.is_on_floor():
		#if velocity.y >= 0:
			#velocity.y -= jump_gravity * delta
		#else:
			#velocity.y -= fall_gravity * delta
	
	player.velocity = player.velocity.lerp(velocity, acceleration * delta)
	#GameManager.player.position = player.global_position
	player.move_and_slide()
	
	var target_rotation = direction.x - player_init_rotation
	#mesh.rotation.y = lerp_angle(mesh.rotation, target_rotation, rotation_speed * delta)

func _jump():
	velocity.y = jump_distance

func _on_set_movement_state(_movement_state: MovementState):
	speed = _movement_state.movement_speed
	acceleration =  _movement_state.acceleration

func _on_set_movement_direction(_movement_direction: Vector2):
	direction = _movement_direction.rotated(camera_rotation + player_init_rotation)
