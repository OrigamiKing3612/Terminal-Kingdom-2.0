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

@export_group("Stage 6")
@export var stage1_clay: Item

func talk(_data: NPCData):
	getStage()

func getStage():
	match GameManager.player.skill.farming.stage:
		0:
			DialogueManager.show_dialogue_balloon(dialogue, "first_time")
			SceneManager.free_cursor()
		1: stage1()
		2: stage2()
		3: stage3()
		4: stage4()
		5: stage5()
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

func stage3():
	var quest = QuestManager.get_quest(stage3_ID)
	if quest == null:
		return
	match quest.quest_status:
		quest.QuestStatus.available:
			quest.start_quest()
			DialogueManager.show_dialogue_balloon(dialogue, "stage3_available")
			QuestManager.update_quest(stage3_ID, quest)
		quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "stage3_started")
			QuestManager.update_quest(stage3_ID, quest)
		quest.QuestStatus.reached_goal:
			DialogueManager.show_dialogue_balloon(dialogue, "stage3_reached_goal")
			quest.finish_quest()
			QuestManager.update_quest(stage3_ID, quest)
			GameManager.player.skill.farming.stage = 4

func stage4():
	var quest = QuestManager.get_quest(stage4_ID)
	if quest == null:
		return
	match quest.quest_status:
		quest.QuestStatus.available:
			quest.start_quest()
			DialogueManager.show_dialogue_balloon(dialogue, "stage4_available")
			QuestManager.update_quest(stage4_ID, quest)
		quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "stage4_started")
			QuestManager.update_quest(stage4_ID, quest)
		quest.QuestStatus.reached_goal:
			DialogueManager.show_dialogue_balloon(dialogue, "stage4_reached_goal")
			var ids = quest.data["materials"]
			GameManager.player.removeItems(ids)
			quest.data["materials"] = []
			quest.finish_quest()
			QuestManager.update_quest(stage4_ID, quest)
			GameManager.player.skill.farming.stage = 5

func stage5():
	var quest = QuestManager.get_quest(stage5_ID)
	if quest == null:
		return
		
	if quest.quest_status == quest.QuestStatus.started:
		quest.start_quest()
		DialogueManager.show_dialogue_balloon(dialogue, "stage5_available")
		QuestManager.update_quest(stage5_ID, quest)
		Utils.givePlayerCountOfItem(stage1_clay, 10)
		return
	
	var _hasCount = GameManager.player.has_count("Pot", 10)
	var has_enough: bool  = _hasCount[0]
	var actual_count: int = _hasCount[1]

	if not has_enough:
		var vars = [
			{ "amount_left": (20 - actual_count) }
		]
		DialogueManager.show_dialogue_balloon(dialogue, "stage5_started", vars)
		return
	else:
		DialogueManager.show_dialogue_balloon(dialogue, "stage5_reached_goal")
		var ids = quest.data["pot_ids"]
		GameManager.player.removeItems(ids)
		quest.data["pot_ids"] = []
		quest.finish_quest()
		QuestManager.update_quest(stage5_ID, quest)
		GameManager.player.skill.farming.stage = 6
		return
