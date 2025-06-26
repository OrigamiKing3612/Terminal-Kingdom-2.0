extends VBoxContainer

signal back

@export var village_id: String = ""

@onready var title: RichTextLabel = $Title
@onready var save_button: Button = $SaveButton

@onready var workplace_select: VBoxContainer = $NPCTemplate/WorkplaceSelect
@onready var workplace_container: VBoxContainer = $NPCTemplate/WorkplaceSelect/ScrollContainer/WorkplaceContainer
@onready var workplace_template_button: Button = $NPCTemplate/WorkplaceSelect/ScrollContainer/WorkplaceContainer/WorkplaceTemplateButton

@onready var job_select: VBoxContainer = $NPCTemplate/JobSelect
@onready var job_container: VBoxContainer = $NPCTemplate/JobSelect/ScrollContainer/JobContainer
@onready var job_template_button: Button = $NPCTemplate/JobSelect/ScrollContainer/JobContainer/JobTemplateButton

var village: Village

func _ready() -> void:
	save_button.hide()
	
func set_data(data: NPCData, id: String):
	self.village_id = id
	village = GameManager.kingdom.villages[village_id]
	title.text = "Edit %s %s (%s)" % [data.name, data.last_name, village.name]

func _on_save_button_pressed() -> void:
	back.emit()
