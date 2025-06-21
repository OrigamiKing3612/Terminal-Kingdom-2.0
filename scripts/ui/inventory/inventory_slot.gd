extends Button
class_name InventorySlot

@onready var backgroud: Sprite2D = $Backgroud
@onready var container: CenterContainer = $CenterContainer

var inventory_item: InventoryItem
var index: int

func insert(item: InventoryItem):
	if not item: 
		push_warning("item is null")
		return
	inventory_item = item
	if item.item_slot:
		if item.item_slot.item:
			tooltip_text = item.item_slot.item.name
	container.add_child(inventory_item)
	
	if not inventory_item.item_slot or GameManager.player.inventory.slots[index] == inventory_item.item_slot:
		return
	
	GameManager.player.inventory.insertSlot(index, inventory_item.item_slot)

func take_item() -> InventoryItem:
	var item = inventory_item
	GameManager.player.inventory.removeSlot(inventory_item.item_slot)
	container.remove_child(inventory_item)
	inventory_item = null
	tooltip_text = ""
	return item
	
func is_empty():
	return !inventory_item
