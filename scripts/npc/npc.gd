extends CharacterBody2D
class_name NPC

@export var data: NPCData
@export var talkable_area: Vector2i = Vector2i(4, 4)

#@onready var marker: MeshInstance2D = $Mesh/Marker
@onready var navigation: NavigationAgent2D = $NavigationAgent2D
@onready var svjobs: StartingVillageJobs = $StartingVillageJobs
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D
@onready var state: Node = $State
@onready var npc_movement_controller: NPCMovement = $NPCMovementController
@onready var npc_brain: NPCBrain = $NPCBrain
@onready var area: Area2D = $Area2D
@onready var marker: AnimatedSprite2D = $Marker

func _ready() -> void:
	if data != null:
		data = data.duplicate()
	marker.visible = false
	
	var shape = RectangleShape2D.new()
	shape.size = talkable_area * 16
	collision_shape.shape = shape

func interact() -> void:
	if data == null:
		push_error("NPC with null data")
	if data.is_starting_village_npc:
		talk_to_starting_village_npc()
		return
	
	print("Talk!")

func talk_to_starting_village_npc():
	match data.current_job:
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

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	marker.visible = true

func _on_body_exited(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	marker.visible = false
