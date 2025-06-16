class_name QuestManager extends Node

@onready var QuestBox: CanvasLayer = GameManager.get_node("QuestBox")
@onready var QuestTitle: RichTextLabel = GameManager.get_node("QuestBox").get_node("QuestTitle")
@onready var QuestDescription: RichTextLabel = GameManager.get_node("QuestBox").get_node("QuestDescription")

@export_multiline var quest_name: String = ""
@export_multiline var quest_description: String = ""
@export var quest_status: QuestStatus = QuestStatus.available
@export_multiline var reached_goal_text: String = ""

enum QuestStatus{available, started, reached_goal, finished}

static var _active_quests: Dictionary = {}

static func register_quest(name: String, quest: QuestManager) -> void:
	_active_quests[name] = quest
	
static func get_quest(name: String) -> QuestManager:
	return _active_quests[name]
	
static func update_quest(name: String, quest: QuestManager) -> void:
	_active_quests[name] = quest
