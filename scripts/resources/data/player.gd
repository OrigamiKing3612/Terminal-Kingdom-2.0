class_name PlayerData extends Resource

signal collect_item(item: Item, count: int)
signal remove_item(item: Item)

@export var name: String = "DEFAULT_NAME"
@export var can_build: bool = true
@export var position: Vector3 = Vector3.ZERO
@export var items: Array[Item] = []

@export var skill: Skill

func collectItem(item: Item, count: int = 1) -> void:
	if not item:
		push_warning("Tried to collect null item")
		return
	for i in count:
		items.append(item)
	collect_item.emit(item, count)
		
func collectItems(items: Array[Item]) -> void:
	if not items:
		push_warning("Tried to collect null items")
		return
	var messages: Dictionary[Item, int] = {}
	for item in items:
		self.items.append(item)
		collect_item.emit(item, 1)

func removeItem(id: String) -> void:
	var removed: Item
	items = items.filter(func(i): 
		if i.id == id:
			removed = i
			return false
		return true)
	remove_item.emit(removed)
		
func removeItems(ids: Array[String]) -> void:
	for id in ids:
		removeItem(id)
		
func removeItemItem(item: Item) -> void:
	if not item:
		push_warning("Tried to remove null item")
		return
	items = items.filter(func(i): 
		if i.name == name:
			return false
		return true)
	remove_item.emit(item)

func has(name: String) -> bool:
	for item in items:
		if item.name == name:
			return true
	return false
	
func hasID(id: String) -> bool:
	for item in items:
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
	for item in items:
		if item.name == name:
			current_count += 1
			if current_count >= count:
				return [true, current_count]
	return [false, current_count]
