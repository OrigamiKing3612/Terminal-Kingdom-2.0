extends MovementController
class_name NPCMovement

func get_movement_direction() -> Vector2:
	return Vector2(0,0)

func set_wants_jump():
	wants_jump = true
