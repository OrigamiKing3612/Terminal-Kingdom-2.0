class_name PlayerData extends Resource

signal collect_item(item: Item, count: int)
signal remove_item(item: Item)

@export var name: String = "DEFAULT_NAME"
@export var can_build: bool = true
@export var position: Vector3 = Vector3.ZERO
# [Item.id, Item]
@export var items: Dictionary[String, Item] = {}

@export var skill: Skill
@export var mining_level: int = 1

func collectItem(item: Item, count: int = 1) -> void:
	if not item:
		push_warning("Tried to collect null item")
		return
	if item.id in items:
		push_warning("Item with ID %s already exists, overwriting." % item.id)
	for i in count:
		items[item.id] = item.copy()
		collect_item.emit(item, count)
		
func collectItems(items: Array[Item]) -> void:
	if not items:
		push_warning("Tried to collect null items")
		return
	for item in items:
		collectItem(item)

func removeItem(id: String) -> void:
	var removed: Item = items[id]
	items.erase(id)
	remove_item.emit(removed)
		
func removeItems(ids: Array[String]) -> void:
	for id in ids:
		removeItem(id)

func removeItemItem(item: Item, count: int = 1) -> void:
	if not item:
		push_warning("Tried to remove null item")
		return
	var removed := 0
	var new_items: Dictionary[String, Item] = {}
	for i in items.values():
		if i.name == item.name and removed < count:
			removed += 1
			remove_item.emit(i)
		else:
			new_items[i.id] = i

	items = new_items

func has(name: String) -> bool:
	for item in items.values():
		if item.name == name:
			return true
	return false
	
func hasTool(tool: Utils.ToolType) -> bool:
	if tool == Utils.ToolType.None:
		return true
	for item in items.values():
		if not item is ToolItem: continue
		if item.tool_type == tool:
			return true
	return false
	
func hasID(id: String) -> bool:
	for item in items.values():
		if item.id == id:
			return true
	return false
	
func hasIDs(ids: Array[String]) -> bool:
	for id in ids:
		if not hasID(id):
			return false
	return true

## Returns [bool, int]: (has_enough, actual_count)
func has_count(name: String, count: int) -> Array:
	var current_count := 0
	for item in items.values():
		if item.name == name:
			current_count += 1
			if current_count >= count:
				return [true, current_count]
	return [false, current_count]
