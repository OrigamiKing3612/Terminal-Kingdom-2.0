extends Recipe
class_name  AnvilRecipe

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
	
	if stage == 6:
		var quest = QuestManager.get_quest("blacksmith6")
		if quest and quest.quest_status == quest.QuestStatus.started:
			quest.reached_goal()
			quest.data["pickaxe_id"] = id_for_stages
			QuestManager.update_quest("blacksmith6", quest)
	elif stage == 7:
		var quest = QuestManager.get_quest("blacksmith7")
		if quest and quest.quest_status == quest.QuestStatus.started:
			quest.step_one_done()
			quest.data["sword_id"] = id_for_stages
			QuestManager.update_quest("blacksmith7", quest)
		
	return true
