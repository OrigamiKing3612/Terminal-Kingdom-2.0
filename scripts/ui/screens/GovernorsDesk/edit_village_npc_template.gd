extends HBoxContainer

signal edit(data: NPCData)

@export var show_edit_button: bool = true

@onready var npc_name: RichTextLabel = $Name
@onready var job: RichTextLabel = $Job
@onready var age: RichTextLabel = $Age
@onready var home: RichTextLabel = $Home
@onready var workplace: RichTextLabel = $Workplace
@onready var placeholder: RichTextLabel = $Placeholder
@onready var edit_button: Button = $Button
var npc_data: NPCData

func _ready() -> void:
	placeholder.visible = !show_edit_button
	edit_button.visible = show_edit_button
	
func set_data(data: NPCData):
	npc_data = data
	npc_name.text = "%s %s" % [data.name, data.last_name]
	job.text = "Unknown"
	for job_name in Utils.Job.keys():
		if Utils.Job[job_name] == data.current_job:
			job.text = job_name
			break
	age.text = str(data.age)
	home.text = str(data.home)
	workplace.text = str(data.workplace)

func _on_button_pressed() -> void:
	edit.emit(npc_data)
