class_name PlantQuest extends QuestManager

func start_quest() -> void:
	if not quest_status == QuestStatus.available:
		return
	quest_status = QuestStatus.started

func reached_goal() -> void:
	if not quest_status == QuestStatus.started:
		return
	quest_status = QuestStatus.reached_goal

func finish_quest() -> void:
	if not quest_status == QuestStatus.reached_goal:
		return
	quest_status = QuestStatus.finished
