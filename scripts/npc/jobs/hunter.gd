extends Node

@export var dialogue: DialogueResource

func talk(data: NPCData) -> void:
	if GameManager.player.skill.blacksmithing.stage == 7:
		var quest = QuestManager.get_quest("blacksmith7")
		if quest.quest_status == quest.QuestStatus.step_two:
			DialogueManager.show_dialogue_balloon(dialogue, "blacksmith_stage7")
			var id = quest.data["sword_id"]
			print_debug("sword_id: ", id)
			if not id:
				push_warning("Hunter (B7): No sword id")
			GameManager.player.removeItems(id)
			quest.data["sword_id"] = []
			quest.reached_goal()
			QuestManager.update_quest("blacksmith7", quest)
	
