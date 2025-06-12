extends CharacterBody3D
#
#@export var speed := 14
#@export var fall_acceleration := 75
#@export var jump_velocity := 20
#@export var mouse_sensitivity := 0.002
#
#var pitch := 0.0
#
#@onready var ray_cast_3d := $Pivot/Camera3D/RayCast3D
#@onready var pivot := $Pivot
#@onready var camera_3d := $Pivot/Camera3D
#@onready var highlight_mesh: MeshInstance3D = $HighlightMesh
#
#func _ready() -> void:
	#velocity = GameData.player.position
	#add_to_group("can_use_doors", true)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#
#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion:
		#pivot.rotate_y(-event.relative.x * mouse_sensitivity)
#
		#pitch = clamp(pitch - event.relative.y * mouse_sensitivity, deg_to_rad(-89), deg_to_rad(89))
		#camera_3d.rotation.x = pitch
#
#func _input(event):
	#if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#
#func _physics_process(delta: float) -> void:
	#var direction = Vector3.ZERO
#
	#if Input.is_action_pressed("move_right"):
		#direction.x += 1
	#if Input.is_action_pressed("move_left"):
		#direction.x -= 1
	#if Input.is_action_pressed("move_back"):
		#direction.z += 1
	#if Input.is_action_pressed("move_forward"):
		#direction.z -= 1
#
	#if direction != Vector3.ZERO:
		#direction = direction.normalized()
		#
		#direction = pivot.global_transform.basis * direction
		#direction.y = 0
#
	#GameData.player.position.x = direction.x * speed
	#GameData.player.position.z = direction.z * speed
#
	#if not is_on_floor():
		#GameData.player.position.y -= fall_acceleration * delta
	#else:
		#GameData.player.position.y = 0
		#if Input.is_action_pressed("jump"):
			#GameData.player.position.y = jump_velocity
#
	#velocity = GameData.player.position
	#
	#if Input.is_action_just_pressed("intract"):
		#if ray_cast_3d.is_colliding():
			#var gridmap_position = ray_cast_3d.get_collision_point() - ray_cast_3d.get_collision_normal()
			#if ray_cast_3d.get_collider().has_method("destroy_tile"):
				#ray_cast_3d.get_collider().destroy_tile(gridmap_position)
#
	#move_and_slide()
signal pressed_jump()
signal set_movement_state(_movement_state: MovementState)
signal set_movement_direction(_movement_state: Vector3)

@export var max_air_jump : int = 1
var air_jump_counter : int = 0

@export var movement_states: Dictionary
var movement_direction: Vector3

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("movement") or event.is_action_released("movement"):
		movement_direction.x = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
		movement_direction.z = Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
		
		if is_movement_ongoing():
			if Input.is_action_pressed("sprint"):
				change_movement_state("sprint")
			else:
				if Input.is_action_pressed("walk"):
					change_movement_state("walk")
				else:
					change_movement_state("run")
		else:
			change_movement_state("stand")
	if event.is_action_pressed("jump"):
		if air_jump_counter <= max_air_jump:
			var jump_name = "ground_jump"
			
			if air_jump_counter > 0:
				jump_name = "air_jump"
			
			pressed_jump.emit()
			# uncomment to enable double jump
			#air_jump_counter += 1

func _ready() -> void:
	change_movement_state("stand")
	
func _physics_process(delta: float) -> void:
	if is_movement_ongoing():
		set_movement_direction.emit(movement_direction)
		
	if is_on_floor():
		air_jump_counter = 0
	elif air_jump_counter == 0:
		air_jump_counter = 1
	
func is_movement_ongoing() -> bool:
	return abs(movement_direction.x) > 0 or abs(movement_direction.z) > 0
	
func change_movement_state(state: String) -> void:
	set_movement_state.emit(movement_states[state])
