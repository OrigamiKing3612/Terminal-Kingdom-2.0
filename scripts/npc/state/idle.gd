extends NPCState

func enter() -> void:
	super()
	character.velocity.x = 0
	character.velocity.z = 0

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> NPCState:
	return null
	
func physics_process(delta: float) -> NPCState:
	character.velocity.y += -gravity * delta
	character.move_and_slide()
	
	if not character.is_on_floor():
		return brain.fall()
		
	return null
