extends CharacterBody3D
class_name NPC

@export var data: NPCData
@export var talkable_area: Vector3 = Vector3(10, 2, 10)

@onready var marker: MeshInstance3D = $Mesh/Marker
@onready var navigation: NavigationAgent3D = $NavigationAgent3D
@onready var svjobs: Node = $StartingVillageJobs
@onready var collision_shape_3d: CollisionShape3D = $Area3D/CollisionShape3D

func _ready() -> void:
	if data != null:
		data = data.duplicate()
	marker.visible = false
	
	var shape = BoxShape3D.new()
	shape.size = talkable_area
	collision_shape_3d.shape = shape

func talk() -> void:
	if data.is_starting_village_npc:
		talk_to_starting_village_npc()
		return
	
	print("Talk!")

func talk_to_starting_village_npc():
	match data.job:
		NPCEnums.Job.None:
			svjobs.none.talk(data)
		NPCEnums.Job.Blacksmith:
			svjobs.blacksmith.talk(data)
		NPCEnums.Job.Miner:
			svjobs.miner.talk(data)
		NPCEnums.Job.King:
			svjobs.king.talk(data)
		NPCEnums.Job.Farmer:
			svjobs.farmer.talk(data)
		NPCEnums.Job.Carpenter:
			svjobs.carpenter.talk(data)
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
	
func _physics_process(delta: float) -> void:
	if marker.visible:
		look_at(GameManager.player.position, Vector3.UP)
