extends Node
class_name NPCBrain

@export var npc: NPC
@export var state_machine: Node
@export var raycast_lower: RayCast3D
@export var raycast_upper: RayCast3D
@export var movement_controller: MovementController

@export_group("States")
@export var idle_state: NPCState
@export var wander_state: NPCState
@export var work_state: NPCState
@export var defend_state: NPCState
@export var jump_state: NPCState
@export var fall_state: NPCState
@export var follow_state: NPCState
@export var talk_to_player: NPCState
@export var walk_to_position: NPCState

@export_group("")
@export var current_goal: NPCState:
	set(newValue):
		if current_goal and not current_goal.state_name in [fall_state.state_name, jump_state.state_name, talk_to_player.state_name]:
			previous_goal = current_goal
		current_goal = newValue
var previous_goal: NPCState

func _ready() -> void:
	state_machine.current_state = current_goal
	previous_goal = idle_state
	state_machine.init()

func _process(_delta: float) -> void:
	#if not npc.data.is_starting_village_npc:
		#print("None State: current state: %s, current goal: %s, previous_goal: %s" % [state_machine.current_state.state_name, current_goal.state_name, previous_goal.state_name])
	pass
	
func _physics_process(delta: float) -> void:
	var lower_hit = raycast_lower.is_colliding()
	var upper_hit = raycast_upper.is_colliding()

	if lower_hit and not upper_hit and (current_goal == follow_state or current_goal == walk_to_position):
		movement_controller.set_wants_jump()
	elif upper_hit:
		movement_controller.wants_jump = false
	else:
		movement_controller.wants_jump = false
	
	if not npc.is_on_floor():# and current_goal != jump_state:
		current_goal = fall_state
	elif npc.is_on_floor():# and current_goal.name == fall_state.name:
		current_goal = previous_goal
		
	if current_goal == walk_to_position:
		if (walk_to_position.navigation as NavigationAgent3D).is_navigation_finished():
			current_goal = idle_state

# return null if can not jump
func jump() -> NPCState:
	return jump_state

# return null if can not fall
func fall() -> NPCState:
	return fall_state

func _on_area_3d_body_entered(_body: Node3D) -> void:
	previous_goal = current_goal
	current_goal = talk_to_player
	state_machine.change_state(talk_to_player)

func _on_area_3d_body_exited(_body: Node3D) -> void:
	state_machine.change_state(previous_goal)
	current_goal = previous_goal
