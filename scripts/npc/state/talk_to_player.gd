extends NPCState

var player: CharacterBody3D

func enter() -> void:
	super()
	character.velocity.x = 0
	character.velocity.z = 0
	player = get_tree().get_first_node_in_group("Player")

func exit() -> void:
	pass

func process_input(event: InputEvent) -> NPCState:
	return null
	
func physics_process(delta: float) -> NPCState:
	character.velocity.y += gravity * delta
	character.move_and_slide()
	
	if player:
		character.look_at(Vector3(player.global_position.x, character.global_position.y, player.global_position.z), Vector3.UP)
	
	if not character.is_on_floor():
		return brain.fall()
	return brain.current_goal
