extends InventorySlot
class_name ToolbeltInventorySlot

signal toolbelt_updated(number: int, inventory_item: InventoryItemSlot)

@export var number: int

func clear(): 
	super()

func insert(item: InventoryItem):
	super(item)
	toolbelt_updated.emit(number, item)

func take_item() -> InventoryItem:
	var item = super()
	toolbelt_updated.emit(number, null) # is null correct?
	return item
