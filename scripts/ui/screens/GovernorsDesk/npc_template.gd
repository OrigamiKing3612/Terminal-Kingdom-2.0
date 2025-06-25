extends Panel
class_name GovernorsScreenNPCTemplate

signal selected(index: int)
var index: int

@onready var selected_panel: Panel = $SelectedPanel
@onready var npc_name: RichTextLabel = $VBoxContainer/NPCName
@onready var age: RichTextLabel = $VBoxContainer/Age
@onready var skill: RichTextLabel = $VBoxContainer/Skill

func _ready() -> void:
	selected_panel.hide()

func set_data(data: NPCData) -> void:
	npc_name.text = "%s %s" % [data.name, data.last_name]
	age.text = "Age: %d" % [data.age]

func select() -> void:
	selected_panel.show()
	
func deselect() -> void:
	selected_panel.hide()

func _on_button_pressed() -> void:
	selected.emit(index)
