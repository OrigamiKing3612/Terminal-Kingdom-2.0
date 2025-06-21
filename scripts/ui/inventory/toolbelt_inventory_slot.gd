extends InventorySlot
class_name ToolbeltInventorySlot

@onready var texture_rect: Sprite2D = $TextureRect

func insert(item: InventoryItem):
	super(item)

func take_item() -> InventoryItem:
	return super()

func selected():
	texture_rect.frame = 0

func deselected():
	texture_rect.frame = 1
