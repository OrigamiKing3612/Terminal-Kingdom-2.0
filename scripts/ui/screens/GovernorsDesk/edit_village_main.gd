extends VBoxContainer

@export var village_id: String = ""
@onready var npc_list: VBoxContainer = $MarginContainer/NPCList
@onready var npc: VBoxContainer = $MarginContainer/NPC

func init(id: String) -> void:
	village_id = id
	npc_list.show()
	npc.hide()
	npc_list.init(village_id)
	npc.village_id = village_id

func _on_npc_list_goto(data: NPCData) -> void:
	npc.set_data(data, village_id)
	npc_list.hide()
	npc.show()

func _on_npc_back() -> void:
	npc_list.show()
	npc.hide()
