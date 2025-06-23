extends NPCState

@export var navigation: NavigationAgent3D
@export var position: Vector3

func enter() -> void:
	super()
	navigation.set_target_position(position)

func physics_process(_delta: float) -> NPCState:
	if navigation.is_navigation_finished():
		return null
	
	if not character.is_on_floor():
		return brain.fall()

	var next_position = navigation.get_next_path_position()
	
	if get_jump():
		return brain.jump()

	var new_velocity = (next_position - character.global_position).normalized() * move_speed
	character.velocity.x = new_velocity.x
	character.velocity.z = new_velocity.z
	#character.look_at(Vector3(next_position.x, character.global_position.y, next_position.z), Vector3.UP)
	character.look_at(next_position, Vector3.UP)
	character.move_and_slide()
	
	return null
