extends VBoxContainer

signal back

@export var village_id: String = ""
@export var data: NPCData

@onready var title: RichTextLabel = $Title
@onready var save_button: Button = $SaveButton

@onready var workplace_select: VBoxContainer = $NPCTemplate/WorkplaceSelect
@onready var workplace_container: VBoxContainer = $NPCTemplate/WorkplaceSelect/ScrollContainer/WorkplaceContainer
@onready var workplace_template_button: Button = $NPCTemplate/WorkplaceSelect/ScrollContainer/WorkplaceContainer/WorkplaceTemplateButton

@onready var job_select: VBoxContainer = $NPCTemplate/JobSelect
@onready var job_container: VBoxContainer = $NPCTemplate/JobSelect/ScrollContainer/JobContainer
@onready var job_template_button: Button = $NPCTemplate/JobSelect/ScrollContainer/JobContainer/JobTemplateButton

var selected_building: BuildingMainTile
var selected_job: Utils.Job
var village: Village

func _ready() -> void:
	save_button.hide()
	workplace_template_button.hide()
	job_template_button.hide()
	
func set_data(data: NPCData, id: String):
	self.village_id = id
	self.data = data
	village = GameManager.kingdom.get_village(village_id)
	title.text = "Edit %s %s (%s)" % [data.name, data.last_name, village.village_name]
	
	for building in village.get_buildings():
		var hiring: HiresComponent = building.get_node_or_null("HiresComponent") as HiresComponent
		if hiring:
			var jobs = hiring.get_jobs()
			#print_debug("Jobs at %s: %s" % [building.building_name, jobs])
			if jobs.size() > 0:
				for job in jobs.keys():
					var button = workplace_template_button.duplicate() as Button
					button.visible = true
					button.text = building.building_name
					button.disabled = jobs[job] # bool if it is taken
					button.pressed.connect(_on_workplace_button_pressed.bind(building))
					workplace_container.add_child(button)

func _on_workplace_button_pressed(building: BuildingMainTile):
	# Clear previous job buttons
	for child in job_container.get_children():
		if child != job_template_button:
			child.queue_free()

	var hiring: HiresComponent = building.get_node_or_null("HiresComponent")
	if hiring:
		for job in hiring.get_jobs():
			var job_button = job_template_button.duplicate()
			job_button.visible = true
			job_button.text = Utils.Job.keys()[job]
			job_button.pressed.connect(_on_job_selected.bind(job, building))
			job_container.add_child(job_button)
			
func _on_job_selected(job: Utils.Job, building: BuildingMainTile):
	selected_building = building
	selected_job = job
	save_button.show()

func _on_save_button_pressed() -> void:
	data.workplace = selected_building.position
	data.has_workplace = true
	data.current_job = selected_job
	var hiring: HiresComponent = selected_building.get_node_or_null("HiresComponent")
	if hiring:
		hiring.get_jobs()[selected_job] = true
	back.emit()
