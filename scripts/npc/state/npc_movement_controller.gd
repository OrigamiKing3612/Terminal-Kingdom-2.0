extends Node

@export var character: CharacterBody3D
@export var animations: AnimatedSprite3D
@export var mesh: Node3D
@export var rotation_speed: float = 8
@export var fall_gravity: float = 45
@export var default_state: NPCState
@export var movement: NPCMovement

@export var brain: NPCBrain

var current_state: NPCState

func init() -> void:
	for child in get_children():
		if child is NPCState:
			child.character = character
			child.animations = animations
			child.movement = movement
			child.brain = brain
		
	change_state(default_state)
	
func change_state(new_state: NPCState) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()
	
