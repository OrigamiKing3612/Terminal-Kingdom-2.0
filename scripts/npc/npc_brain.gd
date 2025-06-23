extends Node
class_name NPCBrain

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

var previous_goal: NPCState
@export_group("")
@export var current_goal: NPCState:
	set(value):
		previous_goal = current_goal
		current_goal = value

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var lower_hit = raycast_lower.is_colliding()
	var upper_hit = raycast_upper.is_colliding()

	if lower_hit and not upper_hit and current_goal == follow_state:
		movement_controller.set_wants_jump()
	elif upper_hit:
		movement_controller.wants_jump = false
	else:
		movement_controller.wants_jump = false

# return null if can not jump
func jump() -> NPCState:
	return jump_state

# return null if can not fall
func fall() -> NPCState:
	return fall_state

func _on_area_3d_body_entered(body: Node3D) -> void:
	current_goal = talk_to_player
	state_machine.current_state = talk_to_player


func _on_area_3d_body_exited(body: Node3D) -> void:
	current_goal = previous_goal
