extends Node
class_name MovementController

@export var character: CharacterBody3D

var wants_jump: bool = false

func get_movement_direction() -> Vector3:
	return Vector3(0,0,0)

func set_wants_jump():
	wants_jump = true
