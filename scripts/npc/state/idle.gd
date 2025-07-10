extends NPCState

func enter() -> void:
	super()
	character.velocity.x = 0
	character.velocity.y = 0

func exit() -> void:
	pass

func physics_process(delta: float) -> void:
	#character.velocity.y += -gravity * delta
	character.move_and_slide()
