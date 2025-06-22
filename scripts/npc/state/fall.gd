extends NPCState

var landing_timer := 0.0
var landing_grace := 0.2 # seconds

func physics_process(delta: float) -> NPCState:
	print(state_name)
	character.velocity.y += -gravity * delta
	character.move_and_slide()
	
	if character.is_on_floor():
		landing_timer += delta
		if landing_timer > landing_grace:
			landing_timer = 0.0
			return brain.current_goal
	else:
		landing_timer = 0.0
	return null
