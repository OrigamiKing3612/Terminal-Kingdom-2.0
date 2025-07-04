extends Node

@export var player: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D
@export var rotation_speed: float = 8
@export var fall_gravity: float = 45
@export var movement_states: Dictionary[String, MovementState]
@export var max_air_jump : int = 1
var air_jump_counter : int = 0
var movement_direction: Vector2
var jump_gravity: float = fall_gravity
var jump_distance: float = 15
var direction: Vector2
var velocity: Vector2
var acceleration: float
var speed: float
var camera_rotation: float = 0
var player_init_rotation: float

func _ready() -> void:
	change_movement_state("stand")

func _physics_process(delta: float) -> void:
	if is_moving():
		set_movement_direction(movement_direction)
		
	if player.is_on_floor():
		air_jump_counter = 0
	elif air_jump_counter == 0:
		air_jump_counter = 1
		
	velocity = speed * direction.normalized()
	
	player.velocity = player.velocity.lerp(velocity, acceleration * delta)
	#GameManager.player.position = player.global_position
	player.move_and_slide()

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("movement") or event.is_action_released("movement")) and GameManager.move and GameManager.mode != GameManager.Mode.Speaking and GameManager.mode != GameManager.Mode.InPopUp:
		movement_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
		
		if is_moving():
			if Input.is_action_pressed("sprint"):
				change_movement_state("sprint")
			else:
				if Input.is_action_pressed("walk"):
					change_movement_state("walk")
				else:
					change_movement_state("run")
		else:
			change_movement_state("stand")
	#if event.is_action_pressed("jump") and (GameManager.mode != GameManager.Mode.InPopUp and GameManager.mode != GameManager.Mode.Inventory and GameManager.mode != GameManager.Mode.Speaking):
		#if air_jump_counter <= max_air_jump:
			#pressed_jump.emit()
			#air_jump_counter += 1
	
func change_movement_state(state: String) -> void:
	var _movement_state = movement_states[state]
	speed = _movement_state.movement_speed
	acceleration = _movement_state.acceleration

	var sprite_direction := "down"
	if player.velocity.x < 0: sprite_direction = "left"
	elif player.velocity.x > 0: sprite_direction = "right"
	elif player.velocity.y < 0: sprite_direction = "up"
	
	if animated_sprite:
		if player.velocity == Vector2.ZERO:
			if animated_sprite.is_playing():
				animated_sprite.stop()
			return
		if _movement_state.animation_name == "idle":
			animated_sprite.play(_movement_state.animation_name + "_" + sprite_direction)
		else:
			animated_sprite.play(_movement_state.animation_name + "_" + sprite_direction)
		animated_sprite.speed_scale = _movement_state.animation_speed
	
func is_moving() -> bool:
	return movement_direction.x != 0 or movement_direction.y != 0

func _jump():
	#velocity.y = jump_distance
	pass

func set_movement_direction(_movement_direction: Vector2):
	direction = _movement_direction.rotated(camera_rotation + player_init_rotation)
