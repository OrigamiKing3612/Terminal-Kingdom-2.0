extends CharacterBody2D

signal pressed_jump()
signal set_movement_state(_movement_state: MovementState)
signal set_movement_direction(_movement_state: Vector2)

@export var max_air_jump : int = 1
var air_jump_counter : int = 0

@export var movement_states: Dictionary
var movement_direction: Vector2

@onready var camera: Camera2D = $Camera2D
@onready var ray_cast: RayCast2D = $RayCast2D

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("movement") or event.is_action_released("movement")) and GameManager.move and GameManager.mode != GameManager.Mode.Speaking and GameManager.mode != GameManager.Mode.InPopUp:
		movement_direction.y = Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
		movement_direction.x = Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
		print("H")
		
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
	if event.is_action_pressed("jump") and (GameManager.mode != GameManager.Mode.InPopUp and GameManager.mode != GameManager.Mode.Inventory and GameManager.mode != GameManager.Mode.Speaking):
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
	return abs(movement_direction.x) > 0
	
func change_movement_state(state: String) -> void:
	set_movement_state.emit(movement_states[state])
	
func _on_left_click():
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		#var path = collider.get_path()
		#var type = collider.get_class()
		#print("> Ray hit: ", path, " (", type, ")")
		if collider is GridMap:
			collider.destroy_tile(ray_cast.get_collision_point())
		elif collider and collider.has_meta("destroyable_component"):
			var component = collider.get_meta("destroyable_component")
			component.destroy()
			
func _on_right_click():
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		#var path = collider.get_path()
		#var type = collider.get_class()
		#print("> Ray hit: ", path, " (", type, ")")
		if collider is GridMap:
			var pos = ray_cast.get_collision_point()
			var normal = ray_cast.get_collision_normal()
			if GameManager.mode == GameManager.Mode.Build:
				if GameManager.selected_tile_id == -1:
					push_warning("Tried to place a tile with -1 as GameManager.selected_tile_id")
					return
				collider.place_tile(pos + normal * 0.5, GameManager.selected_tile_id)
		elif collider.has_meta("interactable_component"):
			var component = collider.get_meta("interactable_component")
			component.interact()
			
	
