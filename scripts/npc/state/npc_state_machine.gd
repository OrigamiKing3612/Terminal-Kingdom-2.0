extends Node

@export var character: CharacterBody3D
@export var animations: AnimatedSprite3D
@export var mesh: Node3D
@export var rotation_speed: float = 8
@export var fall_gravity: float = 45
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
	
func change_state(new_state: NPCState) -> void:
	if not new_state:
		return
	if current_state:
		current_state.exit()
	
	current_state = new_state
	if current_state:
		current_state.enter()
		
func _process(delta: float) -> void:
	if not current_state:
		push_warning("No current state")
		return
	if current_state != brain.current_goal:
		change_state(brain.current_goal)
	
	current_state.process(delta)

func _physics_process(delta: float) -> void:
	if not current_state:
		push_warning("No current state")
		return
	current_state.physics_process(delta)
