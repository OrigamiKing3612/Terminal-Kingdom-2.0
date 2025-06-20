extends NPCState

@export var move_state: NPCState

func physics_process(delta: float) -> NPCState:
	character.velocity.y += gravity * delta

	var move = get_movement_input() * move_speed
	#
	#if move != 0:
		#character.animations.flip_h = movement < 0
	character.velocity.x = move
	character.move_and_slide()
	
	if character.is_on_floor():
		if move != 0:
			return move_state
		return idle_state
	return null
