extends Node

@export var dialogue: DialogueResource

func talk(data: NPCData) -> void:
	if GameManager.player.skill.blacksmithing.stage == 3:
		var quest = QuestManager.get_quest("blacksmith3")
		if quest.quest_status == quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "blacksmith_stage3")
			var ids = quest.data["lumber_ids"]
			GameManager.player.removeItems(ids)
			quest.data["lumber_ids"] = []
			quest.reached_goal()
			QuestManager.update_quest("blacksmith3", quest)
	
