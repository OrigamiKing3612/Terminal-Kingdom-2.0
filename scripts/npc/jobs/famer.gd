extends Node

@export var dialogue: DialogueResource

@export_group("Quest IDs")
@export var stage1_ID: String = "farm1"
@export var stage2_ID: String = "farm2"
@export var stage3_ID: String = "farm3"
@export var stage4_ID: String = "farm4"
@export var stage5_ID: String = "farm5"

@export_group("Stage 1")
@export var stage1_axe: Item  = null

func talk(data: NPCData):
	getStage()

func getStage():
	match GameManager.player.skill.mining.stage:
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
	match quest.quest_status:
		quest.QuestStatus.available:
			GameManager.player.skill.mining.stage = 1
			quest.start_quest()
			DialogueManager.show_dialogue_balloon(dialogue, "stage1_available")
			QuestManager.update_quest(stage1_ID, quest)
		quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "stage1_started")
			QuestManager.update_quest(stage1_ID, quest)
		quest.QuestStatus.reached_goal:
			DialogueManager.show_dialogue_balloon(dialogue, "stage1_reached_goal")
			var id = quest.data["pickaxe_id"]
			GameManager.player.removeItems(id)
			quest.data["pickaxe_id"] = []
			quest.finish_quest()
			QuestManager.update_quest(stage1_ID, quest)
			GameManager.player.skill.mining.stage = 2
