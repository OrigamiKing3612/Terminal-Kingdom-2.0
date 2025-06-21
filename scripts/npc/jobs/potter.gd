extends Node

@export var dialogue: DialogueResource

@export var clay_item: Item
@export var pot_item: Item
@export var coin_item: Item

func talk(_data: NPCData) -> void:
	var vars = [
		{"option": ""}
	]
	DialogueManager.show_dialogue_balloon(dialogue, "start", vars)
	if vars[0]["option"] == "clay":
		GameManager.player.removeItemItem(clay_item, 2)
		var id = Utils.givePlayerCountOfItem(pot_item, 1)
		if GameManager.player.skill.farming.stage == 5:
			var quest = QuestManager.get_quest("farm5")
			quest.data["pot_ids"].append(id)
			QuestManager.update_quest("farm5", quest)
	else:
		GameManager.player.removeItemItem(coin_item, 5)
		Utils.givePlayerCountOfItem(pot_item, 1)
