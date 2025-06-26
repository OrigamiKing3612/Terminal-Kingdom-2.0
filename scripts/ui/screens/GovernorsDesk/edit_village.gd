extends VBoxContainer

const EDIT_VILLAGE_NPC_TEMPLATE = preload("res://scenes/ui/screens/GovernorsDesk/EditVillageNPCTemplate.tscn")
@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer

@export var village_id: String = ""
var npcs: Array[NPC] = []

func _ready() -> void:
	for npc_child in get_tree().get_first_node_in_group("NPCsGroup").get_children():
		if npc_child is NPC:
			if npc_child.data.village_id == village_id:
				npcs.append(npc_child)
				
	for npc in npcs:
		var npc_template = EDIT_VILLAGE_NPC_TEMPLATE.instantiate()
		v_box_container.add_child(npc_template)
		npc_template.set_data(npc.data)
