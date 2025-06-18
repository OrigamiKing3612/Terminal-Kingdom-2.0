extends NPCState

@export var navigation: NavigationAgent3D
@export var wander_radius: float = 10.0
@export var wait_time: float = 1.5  # How long to pause before new target

var area_entered: bool = false

var _wait_timer: float = 0.0

func enter() -> void:
	super()
	area_entered = false
	_wait_timer = 0.0
	pick_new_destination()

func exit() -> void:
	_wait_timer = 0.0

func process(delta: float) -> NPCState:
	if area_entered:
		return idle_state
	if _wait_timer > 0.0:
		_wait_timer -= delta
		if _wait_timer <= 0.0:
			pick_new_destination()
	else:
		_wait_timer = wait_time
	return null

func physics_process(delta: float) -> NPCState:
	if navigation.is_navigation_finished():
		return null

	var next_position = navigation.get_next_path_position()
	var direction = (next_position - character.position).normalized()

	character.velocity = direction * move_speed
	character.move_and_slide()
	
	return null


func pick_new_destination():
	var random_offset = Vector3(
		randf_range(-wander_radius, wander_radius),
		0.0,
		randf_range(-wander_radius, wander_radius)
	)
	var target_position = character.position + random_offset
	navigation.set_target_position(target_position)
	
	_wait_timer = wait_time

func _on_area_3d_area_entered(area: Area3D) -> void:
	area_entered = true
