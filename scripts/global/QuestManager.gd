extends Node
class_name QuestManager

@onready var quest_box: CanvasLayer = GameManager.get_node("QuestBox")
@onready var quest_container: VBoxContainer = GameManager.get_node("QuestBox").get_node("QuestContainer")
const QUEST_TEMPLATE: PackedScene = preload("res://scenes/ui/quest/QuestTemplate.tscn")

@export_multiline var quest_name: String = ""
@export_multiline var quest_description: String = ""
@export var quest_status: QuestStatus = QuestStatus.available
@export_multiline var reached_goal_text: String = ""
@export var data: Dictionary = {}
static var _active_quests: Dictionary[String, QuestManager] = {}

func _ready() -> void:
	update_quest_list()

func update_quest_list() -> void:
	for child in quest_container.get_children():
		child.queue_free()

	for started_quest in _active_quests.values():
		if started_quest.quest_status not in [QuestStatus.available, QuestStatus.finished]:
			var quest = QUEST_TEMPLATE.instantiate()
			quest_container.add_child(quest)
			quest.set_title(started_quest.quest_name)
			match started_quest.quest_status:
				QuestStatus.started:	
					quest.set_description(started_quest.quest_description)
				QuestStatus.reached_goal:
					quest.set_description(started_quest.reached_goal_text)
				QuestStatus.step_two:
					quest.set_description(started_quest.step_two_text)
			
			quest.show()

static func register_quest(id: String, quest: QuestManager) -> void:
	_active_quests[id] = quest
	
static func get_quest(id: String) -> QuestManager:
	return _active_quests[id]
	
static func update_quest(id: String, quest: QuestManager) -> void:
	_active_quests[id] = quest
	quest.update_quest_list()

enum QuestStatus{available, started, reached_goal, finished, step_two}
