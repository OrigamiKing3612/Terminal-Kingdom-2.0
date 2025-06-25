extends NPCState

@export var navigation: NavigationAgent3D
@export var wander_radius: float = 10.0
@export var timer: Timer

var area_entered: bool = false

func enter() -> void:
	super()
	area_entered = false
	timer.one_shot = true
	timer.timeout.connect(_on_timeout)
	pick_new_destination()

func exit() -> void:
	timer.stop()

func physics_process(_delta: float) -> void:
	if navigation.is_navigation_finished():
		if not timer.is_stopped():
			return
		timer.start()
		return
	
	var next_position = navigation.get_next_path_position()
	var direction = (next_position - character.position).normalized()

	character.velocity = direction * move_speed
	character.look_at(Vector3(next_position.x, character.global_position.y, next_position.z), Vector3.UP)
	
	character.move_and_slide()


func pick_new_destination():
	var random_offset = Vector3(
		randf_range(-wander_radius, wander_radius),
		0.0,
		randf_range(-wander_radius, wander_radius)
	)
	var target_position = character.position + random_offset
	navigation.set_target_position(target_position)
	
func _on_timeout():
	pick_new_destination()
