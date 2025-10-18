extends Node
class_name MovementController

@export var character: CharacterBody2D

var wants_jump: bool = false

func get_movement_direction() -> Vector2:
	return Vector2(0,0)

func set_wants_jump():
	wants_jump = true
