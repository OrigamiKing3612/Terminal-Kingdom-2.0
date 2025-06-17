extends Node
class_name Utils

enum Job{None, Blacksmith, King, Miner, Farmer, Docter, Salesman, Potter, Stablemaster, Carpenter, Builder, Hunter, Inventor, Chef}
enum SkillLevel{None, Novice, Apprentice, Journeyman, Expert, Master}
enum BehaviorType{Idle, Wander, Stand, Work}
enum Gender{Male, Female}
enum StationTypes{Anvil, Furnace, Workbench}
enum ToolType{None, Axe, Pickaxe}

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
	var tile_data := TileDB.get_tile(id)
	if tile_data == null:
		push_error("No tile data for ID: %s" % id)
		return false

	if not GameManager.player.hasTool(tile_data.tool_required):
		return false

	var item = tile_data.drop_item.copy()
	
	var count: int 
	if tile_data.min_drop_count != tile_data.max_drop_count:
		count = GameManager.random.randi_range(
			tile_data.min_drop_count, 
			tile_data.max_drop_count
		)
	else: 
		count = tile_data.max_drop_count

	GameManager.player.collectItem(item, count)
	return true
	#if id == 65 or id == 66:
		#if not GameManager.player.has("Axe"):
			#return false
		#var item := Item.new()
		#item.id = UUID.string()
		#item.name = "Lumber"
		#item.price = 2
		#var count = 1
		#if id == 65:
			#count = GameManager.random.randi_range(1, 3)
		#GameManager.player.collectItem(item, count)
	#return true
	
static func load_all_from_path(path: String) -> Array:
	var recipes = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tres"):
				var resource = load(path + "/" + file_name).duplicate()
				recipes.append(resource)
			file_name = dir.get_next()
	return recipes

static func _push_must_override_error(method: String):
	push_error("%s must be overridden in a subclass." % method)
