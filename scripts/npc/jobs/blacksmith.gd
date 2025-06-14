extends Node

@export var dialogue: DialogueResource

@export_group("Quest IDs")
@export var stage1_ID: String = "blacksmith1"
@export var stage2_ID: String = "blacksmith2"
@export var stage3_ID: String = "blacksmith3"
@export var stage4_ID: String = "blacksmith4"
@export var stage5_ID: String = "blacksmith5"

func _ready() -> void:
	QuestManager.register_quest(stage1_ID, $Stage1Quest)
	QuestManager.register_quest(stage2_ID, $Stage2Quest)
	QuestManager.register_quest(stage3_ID, $Stage3Quest)
	QuestManager.register_quest(stage4_ID, $Stage4Quest)
	QuestManager.register_quest(stage5_ID, $Stage5Quest)

func talk(data: NPCData):
	getStage()
	
func getStage():
	match GameManager.player.skill.blacksmithing.stage:
		0:
			DialogueManager.show_dialogue_balloon(dialogue, "first_time")
			SceneManager.free_cursor()
		1:
			stage1()
		2:
			stage2()
		_:
			print("Unknown Stage")
			
func stage1():
	var quest = QuestManager.get_quest(stage1_ID)
	if quest == null:
		return
	if quest.quest_status == quest.QuestStatus.available:
		GameManager.player.skill.blacksmithing.stage = 1
		quest.start_quest()
		DialogueManager.show_dialogue_balloon(dialogue, "stage1_available")
		QuestManager.update_quest(stage1_ID, quest)
		return
		
	if quest.quest_status == quest.QuestStatus.started:
		DialogueManager.show_dialogue_balloon(dialogue, "stage1_started")
		QuestManager.update_quest(stage1_ID, quest)
		return

	if quest.quest_status == quest.QuestStatus.reached_goal:
		GameManager.player.skill.blacksmithing.stage = 2
		DialogueManager.show_dialogue_balloon(dialogue, "stage1_reached_goal")
		quest.finish_quest()
		QuestManager.update_quest(stage1_ID, quest)
		return
	
	
func stage2():
	var quest = QuestManager.get_quest(stage2_ID)
	if quest == null:
		return
	if quest.quest_status == quest.QuestStatus.available:
		GameManager.player.skill.blacksmithing.stage = 1
		DialogueManager.show_dialogue_balloon(dialogue, "stage2_available")
		quest.start_quest()
		 
	if quest.quest_status == quest.QuestStatus.started:
		var has_axe := "value"
		var vars = [
			{ "has_axe": has_axe }
		]
		DialogueManager.show_dialogue_balloon(dialogue, "stage2_started", vars)

	if quest.quest_status == quest.QuestStatus.reached_goal:
		GameManager.player.skill.blacksmithing.stage = 2
		DialogueManager.show_dialogue_balloon(dialogue, "stage2_reached_goal")
		quest.finish_quest()
	
	QuestManager.update_quest(stage2_ID, quest)
