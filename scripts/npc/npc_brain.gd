extends Node
class_name NPCBrain

@export var state_machine: Node

@onready var idle_state: Node = $"../State/Idle"
@onready var wander_state: Node = $"../State/Wander"
@onready var work_state: Node = $"../State/Work"
@onready var defend_state: Node = $"../State/Defend"
@onready var jump_state: Node = $"../State/Jump"
@onready var fall_state: Node = $"../State/Fall"
@onready var follow_state: Node = $"../State/Follow"

var previous_goal: NPCState
var current_goal: NPCState:
	set(value):
		previous_goal = current_goal
		current_goal = value

func _ready() -> void:
	current_goal = follow_state

func _process(_delta: float) -> void:
	pass

# return null if can not jump
func jump() -> NPCState:
	return jump_state

# return null if can not fall
func fall() -> NPCState:
	return fall_state

func _on_area_3d_area_entered(_area: Area3D) -> void:
	current_goal = idle_state


func _on_area_3d_area_exited(_area: Area3D) -> void:
	current_goal = previous_goal
