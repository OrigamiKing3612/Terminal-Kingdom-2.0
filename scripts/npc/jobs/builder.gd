extends Node

@export var dialogue: DialogueResource

@export_group("Quest IDs")
@export var stage1_ID: String = "builder1"
@export var stage2_ID: String = "builder2"
@export var stage3_ID: String = "builder3"
@export var stage4_ID: String = "builder4"
@export var stage5_ID: String = "builder5"

func _ready() -> void:
	QuestManager.register_quest(stage1_ID, $Stage1Quest)

func talk(data: NPCData) -> void:
	getStage()

func getStage():
	match GameManager.player.skill.building.stage:
		0:
			DialogueManager.show_dialogue_balloon(dialogue, "first_time")
			SceneManager.free_cursor()
		1:
			stage1()
		_:
			print("Unknown Stage")
		
func stage1():
	var quest = QuestManager.get_quest(stage1_ID)
	if quest == null:
		return
	if quest.quest_status == quest.QuestStatus.available:
		GameManager.player.skill.building.stage = 1
		quest.start_quest()
		DialogueManager.show_dialogue_balloon(dialogue, "stage1_available")
		QuestManager.update_quest(stage1_ID, quest)
		return
		
	if quest.quest_status == quest.QuestStatus.started:
		DialogueManager.show_dialogue_balloon(dialogue, "stage1_started")
		QuestManager.update_quest(stage1_ID, quest)
		return

	if quest.quest_status == quest.QuestStatus.reached_goal:
		DialogueManager.show_dialogue_balloon(dialogue, "stage1_reached_goal")
		var id = quest.data["materials"]
		GameManager.player.removeItems(id)
		quest.data["materials"] = []
		quest.finish_quest()
		QuestManager.update_quest(stage1_ID, quest)
		GameManager.player.skill.building.stage = 2
		return
	
