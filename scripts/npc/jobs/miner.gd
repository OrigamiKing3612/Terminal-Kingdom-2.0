extends Node

@export var dialogue: DialogueResource
@export var blacksmith_stage1_iron: Item  = null

@export_group("Quest IDs")
@export var stage1_ID: String = "miner1"
@export var stage2_ID: String = "miner2"
@export var stage3_ID: String = "miner3"
@export var stage4_ID: String = "miner4"
@export var stage5_ID: String = "miner5"

func talk(data: NPCData) -> void:
	if GameManager.player.skill.blacksmithing.stage == 1:
		var quest = QuestManager.get_quest("blacksmith1")
		if quest.quest_status == quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "blacksmith_stage1")
			quest.data["iron_ids"] = Utils.givePlayerCountOfItem(blacksmith_stage1_iron.copy(), 5)
			quest.reached_goal()
			QuestManager.update_quest("blacksmith1", quest)
			
	elif GameManager.player.skill.blacksmithing.stage == 4:
		var quest = QuestManager.get_quest("blacksmith4")
		if quest.quest_status == quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "blacksmith_stage4")
			quest.reached_goal()
			QuestManager.update_quest("blacksmith4", quest)
	else:
		getStage()
func getStage():
	match GameManager.player.skill.blacksmithing.stage:
		0:
			DialogueManager.show_dialogue_balloon(dialogue, "first_time")
			SceneManager.free_cursor()
		1:
			stage1()
		#2:
			#stage2()
		#3: 
			#stage3()
		#4: 
			#stage4()
		_:
			print("Unknown Stage")

func stage1():
	var quest = QuestManager.get_quest(stage1_ID)
	if quest == null:
		return
	if quest.quest_status == quest.QuestStatus.available:
		GameManager.player.skill.mining.stage = 1
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
	
