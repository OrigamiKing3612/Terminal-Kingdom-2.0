extends Node

enum Job{None, Blacksmith, King, Miner, Farmer, Docter, Salesman, Potter, Stablemaster, Carpenter, Builder, Hunter, Inventor, Chef}
enum SkillLevel{None, Novice, Apprentice, Journeyman, Expert, Master}
enum BehaviorType{Idle, Wander, Stand, Work}
enum Gender{Male,Female}

## Returns ids of the items
static func givePlayerCountOfItem(itemToDuplicate: Item, count: int) -> Array[String]:
	var items: Array[Item] = []
	var ids: Array[String] = []
	for i in range(count):
		var item := itemToDuplicate.copy()
		ids.append(item.id)
		items.append(item)
	GameManager.player.collectItems(items)
	return ids
	
static func break_tile(id: int) -> bool:
	if id == 65 or id == 66:
		if not GameManager.player.has("Axe"):
			return false
		var item := Item.new()
		item.id = UUID.string()
		item.name = "Lumber"
		item.price = 2
		var count = 1
		if id == 65:
			count = GameManager.random.randi_range(1, 3)
		GameManager.player.collectItem(item, count)
	return true
