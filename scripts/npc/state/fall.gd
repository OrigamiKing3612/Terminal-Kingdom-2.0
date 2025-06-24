extends NPCState

func physics_process(delta: float) -> void:
	character.velocity.y += -gravity * delta
	character.move_and_slide()
