extends Node

@export var dialogue: DialogueResource

func talk(data: NPCData):
	if GameManager.player.skill.building.stage == 4:
		var quest = QuestManager.get_quest("builder1")
		if quest.quest_status == quest.QuestStatus.started:
			DialogueManager.show_dialogue_balloon(dialogue, "builder_stage4")
			quest.reached_goal()
			QuestManager.update_quest("builder1", quest)
			return
	DialogueManager.show_dialogue_balloon(dialogue, "first_dialogue")
	SceneManager.free_cursor()
