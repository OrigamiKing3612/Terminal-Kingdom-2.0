extends CharacterBody3D

signal pressed_jump()
signal set_movement_state(_movement_state: MovementState)
signal set_movement_direction(_movement_state: Vector3)

@export var max_air_jump : int = 1
var air_jump_counter : int = 0

@export var movement_states: Dictionary
var movement_direction: Vector3

@onready var camera: Camera3D = $Camera/CameraYawH/CameraPitchV/SpringArm3D/Camera3D
@onready var ray_cast_3d: RayCast3D = $Camera/CameraYawH/CameraPitchV/SpringArm3D/Camera3D/RayCast3D
@onready var light: DirectionalLight3D = $Camera/CameraYawH/CameraPitchV/SpringArm3D/Camera3D/DirectionalLight3D

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("movement") or event.is_action_released("movement")) and GameManager.move and GameManager.mode != GameManager.Mode.Speaking and GameManager.mode != GameManager.Mode.InPopUp:
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
	if event.is_action_pressed("jump") and GameManager.mode != GameManager.Mode.Speaking and GameManager.mode != GameManager.Mode.InPopUp:
		if air_jump_counter <= max_air_jump:
			pressed_jump.emit()
			air_jump_counter += 1


func _ready() -> void:
	change_movement_state("stand")
	if GameManager.mode == GameManager.Mode.Mining:
		GameManager.mine_left_click.connect(_on_left_click)
	else:
		GameManager.left_click.connect(_on_left_click)
		GameManager.right_click.connect(_on_right_click)
	
func _physics_process(_delta: float) -> void:
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
	
func _on_left_click():
	if ray_cast_3d.is_colliding():
		var collider = ray_cast_3d.get_collider()
		#var path = collider.get_path()
		#var type = collider.get_class()
		#print("> Ray hit: ", path, " (", type, ")")
		if collider is GridMap:
			collider.destroy_tile(ray_cast_3d.get_collision_point())
		elif collider.has_method("destroy"):
			collider.destroy()
			
func _on_right_click():
	if ray_cast_3d.is_colliding():
		var collider = ray_cast_3d.get_collider()
		#var path = collider.get_path()
		#var type = collider.get_class()
		#print("> Ray hit: ", path, " (", type, ")")
		if collider is GridMap:
			var pos = ray_cast_3d.get_collision_point()
			var normal = ray_cast_3d.get_collision_normal()
			collider.place_tile(pos + normal * 0.5, GameManager.selected_gridmap_id)
		elif collider.has_method("interact"):
			collider.interact()
			
	
