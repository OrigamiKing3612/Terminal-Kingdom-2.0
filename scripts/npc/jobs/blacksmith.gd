extends Node


func _ready() -> void:
	QuestManager.register_quest("blacksmith1", $Stage1Quest)

func talk(data: NPCData):
		getStage()
	
func getStage():
	match GameManager.player.skill.blacksmithing.stage:
		0:
			var TALK_MENU = load("res://scenes/menus/dialog.tscn")
			var popup = TALK_MENU.instantiate()
			SceneManager.show_popup(popup)
			popup.show_dialog("Hello "+ GameManager.player.name + "! Would you like to learn how to be a blacksmith?")
			popup.set_yes_or_no(stage1)
			SceneManager.free_cursor()
		1:
			stage1()
		_:
			print("Unknown Stage")

func stage1():
	var quest = QuestManager.get_quest("blacksmith1")
	if quest == null:
		return
	if quest.quest_status == quest.QuestStatus.available:
		GameManager.player.skill.blacksmithing.stage = 1
		quest.start_quest()

	if quest.quest_status == quest.QuestStatus.reached_goal:
		GameManager.player.skill.blacksmithing.stage = 2
		quest.finish_quest()
	
	QuestManager.update_quest("blacksmith1", quest)
