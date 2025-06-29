extends Node

@export var player: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D
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
	pass

func _physics_process(delta: float) -> void:
	velocity = speed * direction.normalized()
	
	player.velocity = player.velocity.lerp(velocity, acceleration * delta)
	#GameManager.player.position = player.global_position
	player.move_and_slide()
	

func _jump():
	#velocity.y = jump_distance
	pass

func _on_set_movement_state(_movement_state: MovementState):
	speed = _movement_state.movement_speed
	acceleration = _movement_state.acceleration

	var sprite_direction := "down"
	if player.velocity.x < 0: sprite_direction = "left"
	elif player.velocity.x > 0: sprite_direction = "right"
	elif player.velocity.y < 0: sprite_direction = "up"

	if player.velocity == Vector2.ZERO:
		if animated_sprite.is_playing():
			animated_sprite.stop()
		return
	if _movement_state.animation_name == "idle":
		animated_sprite.play(_movement_state.animation_name + "_" + sprite_direction)
	else:
		animated_sprite.play(_movement_state.animation_name + "_" + sprite_direction)
	animated_sprite.speed_scale = _movement_state.animation_speed

func _on_set_movement_direction(_movement_direction: Vector2):
	direction = _movement_direction.rotated(camera_rotation + player_init_rotation)
