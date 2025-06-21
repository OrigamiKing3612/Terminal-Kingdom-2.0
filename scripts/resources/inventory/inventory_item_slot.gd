extends Resource
class_name InventoryItemSlot

@export var item_name: String = ""
@export var items: Array[Item] = []

var count: int:
	get: return items.size()

func is_empty() -> bool:
	return items.is_empty()

func add(item: Item) -> void:
	items.append(item)
	if item_name == "":
		item_name = item.name

func remove() -> Item:
	if items.is_empty():
		return null
	return items.pop_back()
	
func removeID(id: String) -> Item:
	if items.is_empty():
		return null
	for item in items:
		if item.id == id:
			return item
	return null

func clear():
	items.clear()
	item_name = ""
