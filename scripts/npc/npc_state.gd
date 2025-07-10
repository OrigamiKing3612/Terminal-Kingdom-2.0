extends Node
## TODO: Rename to EntityState
class_name NPCState

@export var animation_name: String
@export var move_speed: float = 16
@export var state_name: String
@export var step_threshold := 1

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")
var character: CharacterBody2D
var animations: AnimatedSprite2D
var movement: NPCMovement
var brain: NPCBrain

func enter() -> void:
	#animations.play(animation_name)
	pass

func exit() -> void:
	pass

func process(_delta: float) -> void:
	pass
	
func physics_process(_delta: float) -> void:
	pass

# Used for overriding the input
func get_movement_input() -> Vector2:
	return movement.get_movement_direction()

func get_jump() -> bool:
	return movement.wants_jump
