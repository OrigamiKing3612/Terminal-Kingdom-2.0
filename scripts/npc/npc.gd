extends CharacterBody3D
class_name NPC

signal pressed_jump()
signal set_movement_state(_movement_state: MovementState)
signal set_movement_direction(_movement_state: Vector3)

@export var data: NPCData
@export var talkable_area: Vector3 = Vector3(10, 2, 10)

@onready var marker: MeshInstance3D = $Mesh/Marker
@onready var navigation: NavigationAgent3D = $NavigationAgent3D
@onready var svjobs: StartingVillageJobs = $StartingVillageJobs
@onready var collision_shape_3d: CollisionShape3D = $Area3D/CollisionShape3D
@onready var state: Node = $State
@onready var npc_movement_controller: NPCMovement = $NPCMovementController
@onready var npc_brain: NPCBrain = $NPCBrain
@onready var area_3d: Area3D = $Area3D

func _ready() -> void:
	if data != null:
		data = data.duplicate()
	marker.visible = false
	
	var shape = BoxShape3D.new()
	shape.size = talkable_area
	collision_shape_3d.shape = shape
	state.init()

func interact() -> void:
	if data == null:
		push_error("NPC with null data")
	if data.is_starting_village_npc:
		talk_to_starting_village_npc()
		return
	
	print("Talk!")

func talk_to_starting_village_npc():
	match data.job:
		Utils.Job.None:
			svjobs.none.talk(data)
		Utils.Job.Blacksmith:
			svjobs.blacksmith.talk(data)
		Utils.Job.Miner:
			svjobs.miner.talk(data)
		Utils.Job.King:
			svjobs.king.talk(data)
		Utils.Job.Farmer:
			svjobs.farmer.talk(data)
		Utils.Job.Carpenter:
			svjobs.carpenter.talk(data)
		Utils.Job.Hunter:
			svjobs.hunter.talk(data)
		Utils.Job.Builder:
			svjobs.builder.talk()
		_:
			print("Unknown job: ", data.job)

func _on_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		return
	marker.visible = true

func _on_body_exited(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		return
	marker.visible = false

func _process(delta: float) -> void:
	#if not data.is_starting_village_npc:
	var new_state = state.current_state.process(delta)
	if data.job == Utils.Job.Builder:
		print("Builder State: ", state.current_state.state_name)
	if new_state and new_state != state.current_state:
		state.change_state(new_state)

func _physics_process(delta: float) -> void:
	#if not data.is_starting_village_npc:
	var new_state = state.current_state.physics_process(delta)
	if new_state and new_state != state.current_state:
		state.change_state(new_state)
	if marker.visible:
		look_at(GameManager.player.position, Vector3.UP)
