extends VBoxContainer

@onready var hair_selector: HBoxContainer = $HairSelector
@onready var head_eyes_selector: HBoxContainer = $HeadEyesSelector
@onready var torso_selector: HBoxContainer = $TorsoSelector
@onready var legs_selector: HBoxContainer = $LegsSelector

func init() -> void:
	hair_selector.init()
	head_eyes_selector.init()
	torso_selector.init()
	legs_selector.init()
