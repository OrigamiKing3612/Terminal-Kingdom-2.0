class_name PlayerData extends Resource

signal collect_item(item: Item, count: int)
signal remove_item(item: Item)

@export var name: String = "DEFAULT_NAME"
@export var can_build: bool = true
@export var position: Vector3 = Vector3.ZERO
# [Item.id, Item]
@export var inventory: PlayerInventory

@export var skill: Skill
@export var mining_level: int = 1

func collectItem(item: Item, count: int = 1) -> void:
	if not item:
		push_warning("Null item")
		return
	for i in count:
		inventory.insert(item)
	collect_item.emit(item, count)
		
func collectItems(items: Array[Item]) -> void:
	if not items:
		push_warning("Tried to collect null items")
		return
	for item in items:
		collectItem(item)

func removeItem(id: String) -> void:
	var removed := inventory.getID(id)
	if removed:
		inventory.removeID(id)
		remove_item.emit(removed)
		
func removeItems(ids: Array[String]) -> void:
	for id in ids:
		removeItem(id)

func removeItemItem(item: Item, count: int = 1) -> void:
	inventory.removeItem(item, count)
	remove_item.emit(item)

func has(name: String) -> bool:
	return name in inventory.get_items()
	
func hasTool(tool: Utils.ToolType) -> bool:
	if tool == Utils.ToolType.None:
		return true
	for slot in inventory.slots:
		for item in slot.items:
			if item is ToolItem and item.tool_type == tool:
				return true
	return false
	
func hasID(id: String) -> bool:
	return inventory.getID(id) != null

func hasIDs(ids: Array[String]) -> bool:
	for id in ids:
		if not hasID(id):
			return false
	return true

## Returns [bool, int]: (has_enough, actual_count)
func has_count(name: String, count: int) -> Array:
	var current := 0
	for slot in inventory.slots:
		if slot.item_name == name:
			current += slot.count
			if current >= count:
				return [true, current]
	return [false, current]
