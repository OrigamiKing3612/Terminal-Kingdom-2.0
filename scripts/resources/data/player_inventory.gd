extends Resource
class_name  PlayerInventory

@export var slots: Array[InventoryItemSlot] = []

func insert(item: Item):
	for slot in slots:
		if slot.item_name == item.name and slot.count < item.max_amount_per_stack:
			slot.add(item)
			GameManager.inventory_update.emit()
			return

	for slot in slots:
		if slot.is_empty():
			slot.add(item)
			GameManager.inventory_update.emit()
			return

	push_warning("No space for item: %s" % item.name)

func removeSlot(slot: InventoryItemSlot):
	var index = slots.find(slot)
	if index < 0: return
	slots[index] = InventoryItemSlot.new()
	
func insertSlot(index: int, slot: InventoryItemSlot):
	slots[index] = slot

func removeItem(item: Item, count: int = 1) -> void:
	var removed = 0
	for slot in slots:
		if slot.item_name == item.name:
			while not slot.is_empty() and removed < count:
				slot.remove()
				removed += 1
			if slot.is_empty():
				slot.clear()
			if removed >= count:
				break
	GameManager.inventory_update.emit()
	
func removeID(id: String):
	for slot in slots:
		slot.removeID(id)
		GameManager.inventory_update.emit()
		return
	
func getID(id: String) -> Item:
	for slot in slots:
		for item in slot.items:
			if item.id == id:
				return item
	return null

## Returns [String, int]: (item.name, count)
func get_items() -> Dictionary[String, int]:
	var result: Dictionary[String, int] = {}
	for slot in slots:
		if not slot.is_empty():
			if slot.item_name in result:
				result[slot.item_name] += slot.count
			else:
				result[slot.item_name] = slot.count
	return result
