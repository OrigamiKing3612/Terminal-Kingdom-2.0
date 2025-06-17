extends Recipe
class_name FurnaceRecipe

@export var seconds: int = 10

func create() -> bool:
	var stage = GameManager.player.skill.blacksmithing.stage
	if not can_create():
		return false
	for input in inputs:
		GameManager.player.removeItemItem(input.item, input.count)
			
	var id_for_stages: Array[String] = []
	for output in outputs:
		var output_item := output.item
		id_for_stages.append(output_item.id)
		GameManager.player.collectItem(output_item, output.count)

	if stage == 5:
		var quest = QuestManager.get_quest("blacksmith5")
		if quest and quest.quest_status == quest.QuestStatus.started:
			quest.reached_goal()
			QuestManager.update_quest("blacksmith5", quest)
	return true
