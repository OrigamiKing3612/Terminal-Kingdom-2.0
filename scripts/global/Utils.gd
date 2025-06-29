extends Node
class_name Utils

enum Direction{Up,Down,Left,Right}
# if this is changed make sure to add it to npc_data.gd
enum Job{None, Blacksmith, King, Miner, Farmer, Doctor, Salesman, Potter, Stablemaster, Carpenter, 
	Builder, Hunter, Inventor, Chef, Governor, Judge, Bartender}
enum SkillLevel{None, Apprentice, Novice, Advanced, Expert, Master}
enum BehaviorType{Idle, Wander, Stand, Work, Follow}
enum Gender{Male, Female}
enum StationTypes{Anvil, Furnace, Workbench}
enum ToolType{None, Axe, Pickaxe, Sword}
enum SeedType{None, Beet, Cabbage, Carrot, Onion, Pumpkin, TreeSeed}
enum BuildingType { Blacksmith, Mine, Farm, Hospital, Store, Pottery, Stable, Carpentry, Builder, 
	HuntingArea, Inventor, Restruant, Courthouse, Tavern, Castle }

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
	if id < 0: return false
	var tile_data := TileDB.get_tile(id) # drop tile
	if tile_data == null:
		push_error("No tile data for ID: %s" % id)
		return false

	if not GameManager.player.hasTool(tile_data.tool_required):
		return false
	
	if tile_data.drop_item:
		var count: int = tile_data.max_drop_count if tile_data.min_drop_count == tile_data.max_drop_count else GameManager.random.randi_range(
				tile_data.min_drop_count, 
				tile_data.max_drop_count)
		GameManager.player.collectItem(tile_data.drop_item.copy(), count)
	
	if tile_data.second_drop_item:
		var count2: int = tile_data.second_max_drop_count if tile_data.second_min_drop_count == tile_data.second_max_drop_count else GameManager.random.randi_range(
				tile_data.second_min_drop_count, 
				tile_data.second_max_drop_count)
		GameManager.player.collectItem(tile_data.second_drop_item.copy(), count2)

	return true
	
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
	
static func vector_to_orientation(rotation: Vector3i) -> Basis:
	var basis = Basis()
	basis = basis.rotated(Vector3.RIGHT, deg_to_rad(rotation.x))
	basis = basis.rotated(Vector3.UP, deg_to_rad(rotation.y))
	basis = basis.rotated(Vector3.FORWARD, deg_to_rad(rotation.z))
	return basis

func get_all_resources_from_folder(path: String) -> Array:
	var dir = DirAccess.open(path)
	if dir == null:
		push_error("Could not open directory: %s" % path)
		return []
	
	var resources := []
	dir.list_dir_begin()

	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
		if dir.current_is_dir():
			if file_name != "." and file_name != "..":
				var subfolder = path + "/" + file_name
				resources += get_all_resources_from_folder(subfolder)
				continue
		if file_name.ends_with(".import"):
			continue

		var file_path = path + "/" + file_name
		var res = ResourceLoader.load(file_path)
		if res and res is Resource:
			resources.append(res)

	dir.list_dir_end()

	return resources
