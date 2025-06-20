extends Control
class_name InventoryItem

@onready var item_texture: TextureRect = $ItemTexture
@onready var count_label: RichTextLabel = $CountLabel

var item_slot: InventoryItemSlot

func _ready():
	hide()

func update():
	if item_slot:
		item_texture.texture = item_slot.item.texture_2d
		if item_slot.count > 1:
			count_label.text = "x" + str(item_slot.count)
		else:
			count_label.text = ""
		show()
	else:
		item_texture.texture = null
		count_label.text = ""
		hide()
