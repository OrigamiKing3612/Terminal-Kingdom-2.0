extends NPCState

@export var navigation: NavigationAgent2D
@export var position: Vector2

func enter() -> void:
	super()
	navigation.set_target_position(position)

func physics_process(_delta: float) -> void:
	navigation.set_target_position(position)
	if navigation.is_navigation_finished():
		return

	var next_position = navigation.get_next_path_position()

	var new_velocity = (next_position - character.global_position).normalized() * move_speed
	character.velocity.x = new_velocity.x
	character.velocity.y = new_velocity.y
	character.look_at(Vector2(position.x, position.y))
	#character.look_at(next_position, Vector3.UP)
	character.move_and_slide()
