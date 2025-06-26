extends VBoxContainer

signal goto(data: NPCData)

const EDIT_VILLAGE_NPC_TEMPLATE = preload("res://scenes/ui/screens/GovernorsDesk/EditVillageNPCTemplate.tscn")
@onready var v_box_container: VBoxContainer = $ScrollContainer/VBoxContainer

@export var village_id: String = ""
var npcs: Array[NPC] = []

func _ready() -> void:
	var npcs_group = get_tree().get_first_node_in_group("NPCsGroup")
	if npcs_group:
		for npc_child in npcs_group.get_children():
			if npc_child is NPC:
				if npc_child.data.village_id == village_id:
					npcs.append(npc_child)
					
		for npc in npcs:
			var npc_template = EDIT_VILLAGE_NPC_TEMPLATE.instantiate()
			v_box_container.add_child(npc_template)
			npc_template.set_data(npc.data)
			npc_template.edit.connect(_on_edit_button_pressed)

func _on_edit_button_pressed(data: NPCData):
	goto.emit(data)
