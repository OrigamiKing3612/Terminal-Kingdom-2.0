extends CharacterBody3D

@export var data: NPCData

@onready var marker: MeshInstance3D = $Mesh/Marker
@onready var navigation: NavigationAgent3D = $NavigationAgent3D
@onready var jobs: Node = $Jobs

func _ready() -> void:
	if data != null:
		data = data.duplicate()
	marker.visible = false

func talk() -> void:
	if data.is_starting_village_npc:
		talk_to_starting_village_npc()
		return
	
	print("Talk!")

func talk_to_starting_village_npc():
	match data.job:
		NPCEnums.JOB.NONE:
			jobs.none.talk(data)
		NPCEnums.JOB.BLACKSMITH:
			jobs.blacksmith.talk(data)
		NPCEnums.JOB.MINER:
			jobs.miner.talk()
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
		look_at(GameData.player.position, Vector3.UP)
