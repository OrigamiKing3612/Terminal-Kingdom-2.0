extends Node


func talk() -> void:
	var blacksmith_1_quest = QuestManager.get_quest("blacksmith1")
	if blacksmith_1_quest.quest_status == blacksmith_1_quest.QuestStatus.started:
		blacksmith_1_quest.reached_goal()
		QuestManager.update_quest("blacksmith1", blacksmith_1_quest)
