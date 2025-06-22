extends NPCState

@export var navigation: NavigationAgent3D
var character_to_follow: CharacterBody3D

@export var desired_distance := 3.0  # meters

func enter() -> void:
	super()
	character_to_follow = get_tree().get_first_node_in_group("Player")

func physics_process(_delta: float) -> NPCState:
	character.velocity = Vector3.ZERO
	print(state_name)
	
	var target_pos = character_to_follow.global_position
	navigation.set_target_position(target_pos)

	if navigation.is_navigation_finished():
		print("Finished")
		return null
	
	if not character.is_on_floor():
		return brain.fall()
	

	var next_position = navigation.get_next_path_position()
	#var direction = (next_position - character.global_position).normalized()

	character.velocity = (next_position - character.global_position).normalized() * move_speed
	character.look_at(Vector3(character_to_follow.global_position.x, character.global_position.y, character_to_follow.global_position.z), Vector3.UP)
	character.move_and_slide()
	
	return null
