extends Control
class_name GovernorsScreen

@export var position_to_spawn_npcs: Vector3

@onready var npcs_container: HBoxContainer = $"TabContainer/Add NPC/MarginContainer/VBoxContainer/NPCsContainer"
@onready var approve_button: Button = $"TabContainer/Add NPC/MarginContainer/VBoxContainer/ApproveButton"

const NPC_SCENE = preload("res://scenes/npcs/NPC.tscn")
const NPC_TEMPLATE = preload("res://scenes/ui/screens/GovernorsDesk/NPCTemplate.tscn")

var selected_index: int
var npcs: Array[NPCData]

func init() -> void:
	approve_button.hide()
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
		selected_index = index
		if child_index == index:
			children[child_index].select()
			approve_button.show()
		else:
			children[child_index].deselect()
			
func _on_approved() -> void:
	var npc = NPC_SCENE.instantiate()
	npc.data = npcs[selected_index]
	npc.position = position_to_spawn_npcs + Vector3(2, 0, 0)
	get_tree().get_first_node_in_group("NPCsGroup").add_child(npc)
	npc.npc_brain.current_goal = npc.npc_brain.follow_state
	npc.npc_brain.previous_goal = npc.npc_brain.follow_state
	#npc.velocity = Vector3(2, 0, 0)
	SceneManager.hide_popup()
