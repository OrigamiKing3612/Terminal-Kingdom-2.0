extends NPCState

@export var jump_force: float = 7.0

func enter() -> void:
	super()
	character.velocity.y = jump_force

func physics_process(delta: float) -> void:
	movement.wants_jump = false
	#character.velocity.y += -gravity * delta

	#if not character.is_on_floor() and character.velocity.y < 0:
		#return brain.fall()

	character.move_and_slide()
