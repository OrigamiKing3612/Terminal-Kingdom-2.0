extends Node

@export var dialogue: DialogueResource

@export_group("Quest IDs")
@export var stage1_ID: String = "mine1"
@export var stage2_ID: String = "mine2"
@export var stage3_ID: String = "mine3"
@export var stage4_ID: String = "mine4"
@export var stage5_ID: String = "mine5"

@export_group("Other")
@export var blacksmith_stage1_iron: Item  = null
@export var miner_stage1_iron: Item
@export var miner_stage1_stone: Item

func _ready() -> void:
	QuestManager.register_quest(stage1_ID, $Stage1Quest)

func talk(data: NPCData) -> void:
	if GameManager.player.skill.blacksmithing.stage == 1:
		var quest = QuestManager.get_quest("blacksmith1")
		if quest.quest_status == quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "blacksmith_stage1")
			quest.data["iron_ids"] = Utils.givePlayerCountOfItem(blacksmith_stage1_iron, 5)
			quest.reached_goal()
			QuestManager.update_quest("blacksmith1", quest)
			return
	elif GameManager.player.skill.blacksmithing.stage == 4:
		var quest = QuestManager.get_quest("blacksmith4")
		if quest.quest_status == quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "blacksmith_stage4")
			quest.reached_goal()
			QuestManager.update_quest("blacksmith4", quest)
			return
	elif GameManager.player.skill.building.stage == 1:
		var quest = QuestManager.get_quest("builder1")
		if quest.quest_status == quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "builder_stage1")
			quest.data["materials"] = Utils.givePlayerCountOfItem(miner_stage1_iron, 10)
			quest.data["materials"].append(Utils.givePlayerCountOfItem(miner_stage1_stone, 20))
			quest.reached_goal()
			QuestManager.update_quest("builder1", quest)
			return
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
