extends VBoxContainer

signal goto(data: NPCData)

const EDIT_VILLAGE_NPC_TEMPLATE = preload("res://scenes/ui/screens/GovernorsDesk/EditVillageNPCTemplate.tscn")
@onready var v_box_container: VBoxContainer = $ScrollContainer/VBoxContainer

@export var village_id: String = ""
var npcs: Array[NPC] = []
var village: Village

func init(id: String) -> void:
	village_id = id
	village = GameManager.kingdom.get_village(village_id)
	if village:
		npcs = village.get_npcs()

		for npc in npcs:
			var npc_template = EDIT_VILLAGE_NPC_TEMPLATE.instantiate()
			v_box_container.add_child(npc_template)
			npc_template.set_data(npc.data)
			npc_template.edit.connect(_on_edit_button_pressed)

func _on_edit_button_pressed(data: NPCData):
	goto.emit(data)
