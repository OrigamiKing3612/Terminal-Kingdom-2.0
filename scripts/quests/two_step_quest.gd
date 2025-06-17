class_name TwoStepQuest extends QuestManager

@export_multiline var step_two_text: String = ""

func start_quest() -> void:
	if not quest_status == QuestStatus.available:
		return
	quest_status = QuestStatus.started
	#QuestBox.visible = true
	#QuestTitle.text = quest_name
	#QuestDescription.text = quest_description

func step_one_done() -> void:
	if not quest_status == QuestStatus.started:
		return
	quest_status = QuestStatus.step_two
	#QuestBox.visible = true
	#QuestTitle.text = quest_name
	#QuestDescription.text = step_two_text

func reached_goal() -> void:
	if not quest_status == QuestStatus.step_two:
		return
	quest_status = QuestStatus.reached_goal
	
	#QuestDescription.text = reached_goal_text

func finish_quest() -> void:
	if not quest_status == QuestStatus.reached_goal:
		return
	quest_status = QuestStatus.finished
	#QuestBox.visible = false
	
