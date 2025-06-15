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
