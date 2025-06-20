extends Button
class_name InventorySlot

@onready var container: CenterContainer = $CenterContainer

var inventory_item: InventoryItem

func clear(): 
	if inventory_item:
		container.remove_child(inventory_item)
	inventory_item = null
	tooltip_text = ""

func insert(item: InventoryItem):
	if not item: 
		push_warning("item is null")
		return
	inventory_item = item
	tooltip_text = item.item_slot.item.name
	container.add_child(inventory_item)

func take_item() -> InventoryItem:
	var item = inventory_item
	container.remove_child(inventory_item)
	inventory_item = null
	tooltip_text = ""
	return item
	
func is_empty():
	return !inventory_item
