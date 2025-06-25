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
	if data.skills.size() > 0:
		var skill_text := "Experience:\n"
		for skill in data.skills.keys():
			var level_value = data.skills[skill]
			var level_name = "Unknown Skill Level"
			for name in Utils.SkillLevel.keys():
				if Utils.SkillLevel[name] == level_value:
					level_name = name
					break
			var job_name = "Unknown Job"
			for name in Utils.Job.keys():
				if Utils.Job[name] == level_value:
					job_name = name
					break
			skill_text += "%s: %s\n" % [job_name, level_name]
		skill.text = skill_text
	else:
		skill.hide()

func select() -> void:
	selected_panel.show()
	
func deselect() -> void:
	selected_panel.hide()

func _on_button_pressed() -> void:
	selected.emit(index)
