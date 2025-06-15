class_name PlayerData extends Resource

signal collect_item(item: Item, count: int)

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
		items.append(item)
		collect_item.emit(item, 1)

func has(name: String) -> bool:
	for item in items:
		if item.name == name:
			return true
	return false
	
## Returns: [has_enough: bool, amount: int]
func hasCount(name: String, count: int) -> Array:
	var _count := 0
	for item in items:
		if _count == count:
			return [true, _count]
		if item.name == name:
			_count += 1
	return [false, _count]
