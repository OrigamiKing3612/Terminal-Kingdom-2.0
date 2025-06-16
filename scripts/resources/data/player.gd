class_name PlayerData extends Resource

signal collect_item(item: Item, count: int)
signal remove_item(id: String)

@export var name: String = "DEFAULT_NAME"
@export var can_build: bool = true
@export var position: Vector3 = Vector3.ZERO
@export var items: Array[Item] = []

@export var skill: Skill

func collectItem(item: Item, count: int = 1) -> void:
	for i in count:
		items.append(item)
	collect_item.emit(item, count)
		
func collectItems(items: Array[Item]) -> void:
	for item in items:
		self.items.append(item)
		collect_item.emit(item, 1)

func removeItem(id: String) -> void:
	items = items.filter(func(item): return item.id != id)
	remove_item.emit(id)
		
func removeItems(ids: Array[String]) -> void:
	for id in ids:
		removeItem(id)

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

## Returns: [has_enough: bool, amount: int]
func hasCount(name: String, count: int) -> Array:
	var _count := 0
	for item in items:
		if _count == count:
			return [true, _count]
		if item.name == name:
			_count += 1
	return [false, _count]
