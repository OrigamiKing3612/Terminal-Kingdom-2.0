extends Node


func talk() -> void:
	if GameManager.player.skill.blacksmithing.stage == 1:
		var quest = QuestManager.get_quest("blacksmith1")
		if quest.quest_status == quest.QuestStatus.started:
			quest.reached_goal()
			QuestManager.update_quest("blacksmith1", quest)
			
	elif GameManager.player.skill.blacksmithing.stage == 4:
		var quest = QuestManager.get_quest("blacksmith4")
		if quest.quest_status == quest.QuestStatus.started:
			quest.reached_goal()
			QuestManager.update_quest("blacksmith1", quest)
		
