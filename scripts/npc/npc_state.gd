extends Node
class_name NPCState

@export var animation_name: String
@export var move_speed: float = 400
@export var state_name: String

@export_group("Common States")
@export var fall_state: NPCState
@export var idle_state: NPCState
@export var jump_state: NPCState

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")
var character: CharacterBody3D
var animations: AnimatedSprite3D
var movement: NPCMovement

func enter() -> void:
	#animations.play(animation_name)
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> NPCState:
	return null

func process(delta: float) -> NPCState:
	return null
	
func physics_process(delta: float) -> NPCState:
	return null

# Used for overriding the input
func get_movement_input() -> Vector3:
	return movement.get_movement_direction()

func get_jump() -> bool:
	return movement.wants_jump()
