extends NPCState

@export var move_state: NPCState

func physics_process(delta: float) -> NPCState:
	character.velocity.y += gravity * delta

	var movement = get_movement_input() * move_speed
	#
	#if movement != 0:
		#character.animations.flip_h = movement < 0
	character.velocity.x = movement
	character.move_and_slide()
	
	if character.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	return null
