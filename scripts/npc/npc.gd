extends CharacterBody3D

@export var starting_village_npc: bool = false
@export var job = ""
@onready var marker: MeshInstance3D = $Mesh/Marker
@onready var navigation: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	marker.visible = false

func talk() -> void:
	if starting_village_npc:
		print("Im a starting village NPC")
		return
	
	print("Talk!")

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
