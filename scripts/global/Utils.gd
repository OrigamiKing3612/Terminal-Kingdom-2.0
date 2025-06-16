extends Node

enum Job{None, Blacksmith, King, Miner, Farmer, Docter, Salesman, Potter, Stablemaster, Carpenter, Builder, Hunter, Inventor, Chef}
enum SkillLevel{None, Novice, Apprentice, Journeyman, Expert, Master}
enum BehaviorType{Idle, Wander, Stand, Work}
enum Gender{Male,Female}

## Returns ids of the items
func givePlayerCountOfItem(itemToDuplicate: Item, count: int) -> Array[String]:
	var items: Array[Item] = []
	var ids: Array[String] = []
	for i in range(count):
		var id := UUID.string()
		var item := itemToDuplicate.duplicate()
		item.id = id
		ids.append(id)
		items.append(item)
	GameManager.player.collectItems(items)
	return ids
	
