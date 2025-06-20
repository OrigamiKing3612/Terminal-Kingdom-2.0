extends NPCState

@export var wait_time: float = 2.0
var _timer: float = 0.0

func enter() -> void:
	super()
	character.velocity.x = 0
	character.velocity.z = 0
	_timer = wait_time

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> NPCState:
	if get_jump() and character.is_on_floor():
		return jump_state
	return null
	
func physics_process(delta: float) -> NPCState:
	character.velocity.y += gravity * delta
	character.move_and_slide()
	
	if not character.is_on_floor():
		return fall_state
	return null
