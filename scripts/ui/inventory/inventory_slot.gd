extends Button
class_name InventorySlot

@onready var container: CenterContainer = $CenterContainer

var inventory_item: InventoryItem

func clear(): 
	if inventory_item:
		container.remove_child(inventory_item)
	inventory_item = null

func insert(item: InventoryItem):
	inventory_item = item
	container.add_child(inventory_item)

func take_item() -> InventoryItem:
	var item = inventory_item
	container.remove_child(inventory_item)
	inventory_item = null
	return item
	
func is_empty():
	return !inventory_item
