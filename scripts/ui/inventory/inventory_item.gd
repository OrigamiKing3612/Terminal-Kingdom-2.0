extends Control
class_name InventoryItem

@onready var item_texture: TextureRect = $ItemTexture
@onready var count_label: RichTextLabel = $CountLabel

var item_slot: InventoryItemSlot

func _ready():
	hide()

func update(slot: InventoryItemSlot):
	item_slot = slot
	if slot:
		item_texture.texture = slot.item.texture_2d
		if slot.count > 1:
			count_label.text = "x" + str(slot.count)
		else:
			count_label.text = ""
		tooltip_text = slot.item.name
		show()
	else:
		item_texture.texture = null
		count_label.text = ""
		tooltip_text = ""
		hide()
