extends Node

@export var dialogue: DialogueResource
@export var brain: NPCBrain
@export var npc: NPC

@export_group("Quest IDs")
@export var stage1_ID: String = "builder1"
@export var stage2_ID: String = "builder2"
@export var stage3_ID: String = "builder3"
@export var stage4_ID: String = "builder4"
@export var stage5_ID: String = "builder5"
@export var stage6_ID: String = "builder6"
@export var stage7_ID: String = "builder7"

@export_group("Stage 2")
@export var stage2_axe: Item

@export_group("Stage 3")
@export var stage3_lumber_item: Item

@export_group("Stage 5")
@export var stage5_items: Array[Item]

func _ready() -> void:
	QuestManager.register_quest(stage1_ID, $Stage1Quest)
	QuestManager.register_quest(stage2_ID, $Stage2Quest)
	QuestManager.register_quest(stage3_ID, $Stage3Quest)
	QuestManager.register_quest(stage4_ID, $Stage4Quest)
	QuestManager.register_quest(stage5_ID, $Stage5Quest)
	QuestManager.register_quest(stage6_ID, $Stage6Quest)
	QuestManager.register_quest(stage7_ID, $Stage7Quest)

func talk() -> void:
	getStage()

func getStage():
	match GameManager.player.skill.building.stage:
		0:
			DialogueManager.show_dialogue_balloon(dialogue, "first_time")
			SceneManager.free_cursor()
		1: stage1()
		2: stage2()
		3: stage3()
		4: stage4()
		5: stage5()
		
		8: stage8()
		9: stage9()
		_: push_warning("Unknown Stage")
		
func stage1():
	var quest = QuestManager.get_quest(stage1_ID)
	if quest == null:
		return
	match quest.quest_status:
		quest.QuestStatus.available:
			GameManager.player.skill.building.stage = 1
			quest.start_quest()
			DialogueManager.show_dialogue_balloon(dialogue, "stage1_available")
			QuestManager.update_quest(stage1_ID, quest)
		quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "stage1_started")
			QuestManager.update_quest(stage1_ID, quest)
		quest.QuestStatus.reached_goal:
			DialogueManager.show_dialogue_balloon(dialogue, "stage1_reached_goal")
			var id = quest.data["materials"]
			GameManager.player.removeItems(id)
			quest.data["materials"] = []
			quest.finish_quest()
			QuestManager.update_quest(stage1_ID, quest)
			GameManager.player.skill.building.stage = 2

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
		GameManager.player.skill.building.stage = 3
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
			quest.start_quest()
			Utils.givePlayerCountOfItem(stage3_lumber_item, 5)
			QuestManager.update_quest(stage3_ID, quest)
		quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "stage3_started")
		quest.QuestStatus.reached_goal:
			GameManager.player.skill.blacksmithing.stage = 4
			DialogueManager.show_dialogue_balloon(dialogue, "stage3_reached_goal")
			quest.finish_quest()
			QuestManager.update_quest(stage3_ID, quest)
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
	if quest.quest_status != quest.QuestStatus.available and quest.quest_status != quest.QuestStatus.finished:
		if GameManager.random_data["builder5"]["done_building"]:
			quest.reached_goal()
	if quest == null:
		return
	match quest.quest_status:
		quest.QuestStatus.available:
			DialogueManager.show_dialogue_balloon(dialogue, "stage5_available")
			quest.data["data"] = {"ready": false}
			quest.start_quest()
			QuestManager.update_quest(stage5_ID, quest)
			npc.data.workplace = brain.current_goal.character.position
			brain.current_goal = brain.follow_state
			GameManager.random_data["builder5"] = {"ready": false, "done_building": false}
		quest.QuestStatus.started:
			quest.data["data"]["ready"] = GameManager.random_data["builder5"]["ready"]
			if not quest.data["data"]["ready"]:
				await DialogueManager.show_dialogue_balloon(dialogue, "stage5_start")
				DialogueManager.dialogue_ended.connect(func(resource: DialogueResource):
					if GameManager.random_data["builder5"]["ready"]:
						quest.data["ids"] = []
						for item in stage5_items:
							quest.data["ids"].append(Utils.givePlayerCountOfItem(item, 30))
						brain.current_goal = brain.idle_state
					, CONNECT_ONE_SHOT
				)
			else:
				DialogueManager.show_dialogue_balloon(dialogue, "stage5_started")
		quest.QuestStatus.reached_goal:
			GameManager.player.skill.blacksmithing.stage = 6
			DialogueManager.show_dialogue_balloon(dialogue, "stage5_reached_goal")
			quest.finish_quest()
			brain.walk_to_position.position = npc.data.workplace
			brain.current_goal = brain.walk_to_position
			QuestManager.update_quest(stage5_ID, quest)
			GameManager.random_data.erase("builder5")

func stage8():
	DialogueManager.show_dialogue_balloon(dialogue, "stage8_available")
	GameManager.player.skill.building.stage = 9
	
func stage9():
	DialogueManager.show_dialogue_balloon(dialogue, "stage9_available")
	GameManager.player.skill.building.stage = 10
	
