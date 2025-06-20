extends NPCState

@export var jump_force: float = 900.0

@export var move_state: NPCState

func enter() -> void:
	super()
	character.velocity.y = -jump_force
	
func physics_process(delta: float) -> NPCState:
	character.velocity.y += gravity * delta
	if character.velocity.y > 0:
		return fall_state
	
	var move = get_movement_input() * move_speed
	if move != 0:
		# look at direction
		pass
	
	# character.velocity.
	character.move_and_slide()
	
	if character.is_on_floor():
		if move != 0:
			return move_state
		return idle_state
	
	return null
