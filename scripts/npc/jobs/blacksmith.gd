extends Node

@export var dialogue: DialogueResource

@export_group("Quest IDs")
@export var stage1_ID: String = "blacksmith1"
@export var stage2_ID: String = "blacksmith2"
@export var stage3_ID: String = "blacksmith3"
@export var stage4_ID: String = "blacksmith4"
@export var stage5_ID: String = "blacksmith5"
@export var stage6_ID: String = "blacksmith6"
@export var stage7_ID: String = "blacksmith7"
@export var stage8_ID: String = "blacksmith8"
@export var stage9_ID: String = "blacksmith9"

@export_group("Stage 2")
@export var stage2_axe: ToolItem

@export_group("Stage 3")
@export var stage3_lumber_item: Item = null

@export_group("Stage 5")
@export var stage5_iron_item: Item = null
@export var stage5_coal_item: Item = null

@export_group("Stage 6")
@export var stage6_steel_item: Item = null
@export var stage6_stick_item: Item = null

@export_group("Other")
@export var mine_stage1_pickaxe: Item = null

func _ready() -> void:
	QuestManager.register_quest(stage1_ID, $Stage1Quest)
	QuestManager.register_quest(stage2_ID, $Stage2Quest)
	QuestManager.register_quest(stage3_ID, $Stage3Quest)
	QuestManager.register_quest(stage4_ID, $Stage4Quest)
	QuestManager.register_quest(stage5_ID, $Stage5Quest)
	QuestManager.register_quest(stage6_ID, $Stage6Quest)
	QuestManager.register_quest(stage7_ID, $Stage7Quest)

func talk(_data: NPCData):
	if GameManager.player.skill.mining.stage == 1:
		var quest = QuestManager.get_quest("mine1")
		if quest.quest_status == quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "mine_stage1")
			quest.data["pickaxe_id"] = Utils.givePlayerCountOfItem(mine_stage1_pickaxe.copy(), 1)
			quest.reached_goal()
			QuestManager.update_quest("mine1", quest)
			return
	getStage()
	
func getStage():
	match GameManager.player.skill.blacksmithing.stage:
		0:
			DialogueManager.show_dialogue_balloon(dialogue, "first_time")
			SceneManager.free_cursor()
		1: stage1()
		2: stage2()
		3: stage3()
		4: stage4()
		5: stage5()
		6: stage6()
		7: stage7()
		_: push_warning("Unknown Stage")
			
func stage1():
	var quest = QuestManager.get_quest(stage1_ID)
	if quest == null:
		return
	match quest.quest_status:
		quest.QuestStatus.available:
			GameManager.player.skill.blacksmithing.stage = 1
			quest.start_quest()
			DialogueManager.show_dialogue_balloon(dialogue, "stage1_available")
			QuestManager.update_quest(stage1_ID, quest)
		quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "stage1_started")
		quest.QuestStatus.reached_goal:
			var ids = quest.data["iron_ids"]
			if GameManager.player.hasIDs(ids):
				DialogueManager.show_dialogue_balloon(dialogue, "stage1_reached_goal")	
				quest.finish_quest()
				QuestManager.update_quest(stage1_ID, quest)
				GameManager.player.removeItems(ids)
				GameManager.player.skill.blacksmithing.stage = 2
			else:
				DialogueManager.show_dialogue_balloon(dialogue, "stage1_error")
	
	
func stage2():
	var quest = QuestManager.get_quest(stage2_ID)
	if quest == null:
		return
	if quest.quest_status == quest.QuestStatus.available:
		DialogueManager.show_dialogue_balloon(dialogue, "stage2_available")
		var id = Utils.givePlayerCountOfItem(stage2_axe, 1)
		quest.data["axe_id"] = id
		quest.start_quest()
		QuestManager.update_quest(stage2_ID, quest)
		return

	var _hasCount = GameManager.player.has_count("Lumber", 20)
	var has_enough: bool  = _hasCount[0]
	var actual_count: int = _hasCount[1]

	if not has_enough:
		var axe_id = quest.data["axe_id"]
		var has_axe := GameManager.player.hasID(axe_id)
		var vars = [
			{ "has_axe": has_axe },
			{ "amount_left": (20 - actual_count) }
		]
		DialogueManager.show_dialogue_balloon(dialogue, "stage2_started", vars)
		return
	else:
		quest.reached_goal()
		GameManager.player.skill.blacksmithing.stage = 3
		DialogueManager.show_dialogue_balloon(dialogue, "stage2_reached_goal")
		quest.finish_quest()
		QuestManager.update_quest(stage2_ID, quest)
		return
	

func stage3():
	var quest = QuestManager.get_quest(stage3_ID)
	if quest == null:
		return
	match quest.quest_status:
		quest.QuestStatus.available:
			DialogueManager.show_dialogue_balloon(dialogue, "stage3_available")
			quest.data["lumber_ids"] = Utils.givePlayerCountOfItem(stage3_lumber_item.copy(), 5)
			quest.start_quest()
			QuestManager.update_quest(stage3_ID, quest)
		quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "stage3_started")
		quest.QuestStatus.reached_goal:
			DialogueManager.show_dialogue_balloon(dialogue, "stage3_reached_goal")
			quest.finish_quest()
			QuestManager.update_quest(stage3_ID, quest)
			GameManager.player.skill.blacksmithing.stage = 4

func stage4():
	var quest = QuestManager.get_quest(stage4_ID)
	if quest == null:
		return
	match quest.quest_status:
		quest.QuestStatus.available:
			DialogueManager.show_dialogue_balloon(dialogue, "stage4_available")
			quest.start_quest()
			QuestManager.update_quest(stage4_ID, quest)
		quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "stage4_started")
		quest.QuestStatus.reached_goal:
			GameManager.player.skill.blacksmithing.stage = 5
			DialogueManager.show_dialogue_balloon(dialogue, "stage4_reached_goal")
			quest.finish_quest()
			QuestManager.update_quest(stage4_ID, quest)

func stage5():
	var quest = QuestManager.get_quest(stage5_ID)
	if quest == null:
		return
	match quest.quest_status:
		quest.QuestStatus.available:
			DialogueManager.show_dialogue_balloon(dialogue, "stage5_available")
			quest.start_quest()
			GameManager.player.collectItems([stage5_coal_item.copy(), stage5_iron_item.copy()])
			QuestManager.update_quest(stage5_ID, quest)
		quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "stage5_started")
		quest.QuestStatus.reached_goal:
			GameManager.player.skill.blacksmithing.stage = 6
			DialogueManager.show_dialogue_balloon(dialogue, "stage5_reached_goal")
			quest.finish_quest()
			QuestManager.update_quest(stage5_ID, quest)
			
func stage6():
	var quest = QuestManager.get_quest(stage6_ID)
	if quest == null:
		return
	match quest.quest_status:
		quest.QuestStatus.available:
			DialogueManager.show_dialogue_balloon(dialogue, "stage6_available")
			quest.start_quest()
			GameManager.player.collectItems([stage6_steel_item.copy(), stage6_stick_item.copy()])
			QuestManager.update_quest(stage6_ID, quest)
		quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "stage6_started")
		quest.QuestStatus.reached_goal:
			GameManager.player.skill.blacksmithing.stage = 7
			DialogueManager.show_dialogue_balloon(dialogue, "stage6_reached_goal")
			quest.finish_quest()
			QuestManager.update_quest(stage6_ID, quest)
			
func stage7():
	var quest = QuestManager.get_quest(stage7_ID)
	if quest == null:
		return
	match quest.quest_status:
		quest.QuestStatus.available:
			DialogueManager.show_dialogue_balloon(dialogue, "stage7_available")
			quest.start_quest()
			GameManager.player.collectItems([stage6_steel_item.copy(), stage6_stick_item.copy()])
			QuestManager.update_quest(stage7_ID, quest)
		quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "stage7_started")
		quest.QuestStatus.step_two:
			DialogueManager.show_dialogue_balloon(dialogue, "stage7_step_two")
		quest.QuestStatus.reached_goal:
			GameManager.player.skill.blacksmithing.stage = 8
			DialogueManager.show_dialogue_balloon(dialogue, "stage7_reached_goal")
			quest.finish_quest()
			QuestManager.update_quest(stage7_ID, quest)
