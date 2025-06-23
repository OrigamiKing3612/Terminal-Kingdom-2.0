extends NPCState

func physics_process(delta: float) -> NPCState:
	character.velocity.y += -gravity * delta
	character.move_and_slide()
	
	if character.is_on_floor():
		return brain.current_goal
	return null
