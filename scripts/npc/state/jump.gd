extends NPCState

@export var jump_force: float = 900.0

@export var move_state: NPCState

func enter() -> void:
	super()
	character.velocity.y = -jump_force
	
func physics_process(delta: float) -> NPCState:
	print(state_name)
	character.velocity.y += gravity * delta
	if character.velocity.y > 0:
		return brain.fall()
	
	var move = get_movement_input() * move_speed
	if move != 0:
		# look at direction
		pass
	
	# character.velocity.
	character.move_and_slide()
	
	if character.is_on_floor():
		return brain.current_goal
	return null
