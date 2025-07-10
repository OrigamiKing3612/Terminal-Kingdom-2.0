extends VBoxContainer

@onready var blacksmith: HBoxContainer = $HBoxContainer/VBoxContainer/Blacksmith
@onready var mining: HBoxContainer = $HBoxContainer/VBoxContainer/Mining
@onready var carpentry: HBoxContainer = $HBoxContainer/VBoxContainer/Carpentry
@onready var farming: HBoxContainer = $HBoxContainer/VBoxContainer/Farming
@onready var building: HBoxContainer = $HBoxContainer/VBoxContainer/Building
@onready var hunting: HBoxContainer = $HBoxContainer/VBoxContainer/Hunting
@onready var caretaking: HBoxContainer = $HBoxContainer/VBoxContainer/Caretaking
@onready var medicine: HBoxContainer = $HBoxContainer/VBoxContainer/Medicine
@onready var cooking: HBoxContainer = $HBoxContainer/VBoxContainer/Cooking

# Called when the node enters the scene tree for the first time.
func init() -> void:
	var keys = Utils.SkillLevel.keys()
	blacksmith.get_node("ValueLabel").text = keys[GameManager.player.skill.blacksmithing.level]
	mining.get_node("ValueLabel").text = keys[GameManager.player.skill.mining.level]
	farming.get_node("ValueLabel").text = keys[GameManager.player.skill.farming.level]
	building.get_node("ValueLabel").text = keys[GameManager.player.skill.building.level]
	hunting.get_node("ValueLabel").text = keys[GameManager.player.skill.hunting.level]
	caretaking.get_node("ValueLabel").text = keys[GameManager.player.skill.caretaking.level]
	medicine.get_node("ValueLabel").text = keys[GameManager.player.skill.medicine.level]
	cooking.get_node("ValueLabel").text = keys[GameManager.player.skill.cooking.level]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
