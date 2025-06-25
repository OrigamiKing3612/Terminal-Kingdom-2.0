extends Control
class_name GovernorsScreen

@onready var npcs_container: HBoxContainer = $"TabContainer/Add NPC/VBoxContainer/NPCsContainer"

const NPC_TEMPLATE = preload("res://scenes/ui/screens/GovernorsDesk/NPCTemplate.tscn")

var npcs: Array[NPCData]

func init() -> void:
	for i in range(3):
		var data := NPCData.create_new()
		npcs.append(data)
		
	for index in npcs.size():
		var npc_display = NPC_TEMPLATE.instantiate()
		npcs_container.add_child(npc_display)
		npc_display.selected.connect(_on_selected)
		npc_display.index = index
		npc_display.set_data(npcs[index])

func _on_selected(index: int):
	var children = npcs_container.get_children()
	for child_index in children.size():
		if child_index == index:
			children[child_index].select()
		else:
			children[child_index].deselect()
