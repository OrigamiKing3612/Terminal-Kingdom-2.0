extends NPCState

@export var navigation: NavigationAgent3D
var character_to_follow: CharacterBody3D

func enter() -> void:
	super()
	character_to_follow = get_tree().get_first_node_in_group("Player")

func physics_process(_delta: float) -> NPCState:
	var distance_to_player := character.global_position.distance_to(character_to_follow.global_position)

	if distance_to_player > navigation.path_desired_distance:
		var target_pos = character_to_follow.global_position
		navigation.set_target_position(target_pos)
	else:
		navigation.set_target_position(character.global_position)
		character.velocity.x = 0.0
		character.velocity.z = 0.0

	if navigation.is_navigation_finished():
		return null
	
	if not character.is_on_floor():
		return brain.fall()

	var next_position = navigation.get_next_path_position()
	var y_difference = next_position.y - character.global_position.y
	
	if y_difference > step_threshold:
		return brain.jump()
	

	var new_velocity = (next_position - character.global_position).normalized() * move_speed
	character.velocity.x = new_velocity.x
	character.velocity.z = new_velocity.z
	character.look_at(Vector3(character_to_follow.global_position.x, character.global_position.y, character_to_follow.global_position.z), Vector3.UP)
	#character.look_at(next_position)
	character.move_and_slide()
	
	return null
