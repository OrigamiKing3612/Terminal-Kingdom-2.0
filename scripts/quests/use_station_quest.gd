class_name UseStationQuest extends QuestManager

func start_quest() -> void:
	if not quest_status == QuestStatus.available:
		return
	quest_status = QuestStatus.started
	QuestBox.visible = true
	QuestTitle.text = quest_name
	QuestDescription.text = quest_description

func reached_goal() -> void:
	if not quest_status == QuestStatus.started:
		return
	quest_status = QuestStatus.reached_goal
	
	QuestDescription.text = reached_goal_text

func finish_quest() -> void:
	if not quest_status == QuestStatus.reached_goal:
		return
	quest_status = QuestStatus.finished
	QuestBox.visible = false
	
