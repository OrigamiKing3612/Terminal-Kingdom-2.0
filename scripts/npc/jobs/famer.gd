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
@export var stage1_tree_seed: Item  = null

func talk(data: NPCData):
	getStage()

func getStage():
	match GameManager.player.skill.farming.stage:
		0:
			DialogueManager.show_dialogue_balloon(dialogue, "first_time")
			SceneManager.free_cursor()
		1:
			stage1()
		2:
			stage2()
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
			GameManager.player.skill.farming.stage = 1
			quest.start_quest()
			quest.data["axe_id"] = Utils.givePlayerCountOfItem(stage1_axe, 1)
			DialogueManager.show_dialogue_balloon(dialogue, "stage1_available")
			QuestManager.update_quest(stage1_ID, quest)
		quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "stage1_started")
			QuestManager.update_quest(stage1_ID, quest)
		quest.QuestStatus.reached_goal:
			DialogueManager.show_dialogue_balloon(dialogue, "stage1_reached_goal")
			var id = quest.data["axe_id"]
			GameManager.player.removeItems(id)
			quest.data["axe_id"] = []
			GameManager.player.removeItemItem(stage1_tree_seed.copy(), 1)
			quest.finish_quest()
			QuestManager.update_quest(stage1_ID, quest)
			GameManager.player.skill.farming.stage = 2

func stage2():
	var quest = QuestManager.get_quest(stage2_ID)
	if quest == null:
		return
	match quest.quest_status:
		quest.QuestStatus.available:
			quest.start_quest()
			Utils.givePlayerCountOfItem(stage1_tree_seed, 1)
			DialogueManager.show_dialogue_balloon(dialogue, "stage2_available")
			QuestManager.update_quest(stage2_ID, quest)
		quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "stage2_started")
			QuestManager.update_quest(stage2_ID, quest)
		quest.QuestStatus.reached_goal:
			DialogueManager.show_dialogue_balloon(dialogue, "stage2_reached_goal")
			quest.finish_quest()
			QuestManager.update_quest(stage2_ID, quest)
			GameManager.player.skill.farming.stage = 3
