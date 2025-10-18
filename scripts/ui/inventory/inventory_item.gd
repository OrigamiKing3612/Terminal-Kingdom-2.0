extends Control
class_name InventoryItem

@onready var item_texture: TextureRect = $ItemTexture
@onready var count_label: RichTextLabel = $CountLabel
@onready var durability_bar: ProgressBar = $DurabilityBar

var item_slot: InventoryItemSlot

func _ready():
	hide()
	durability_bar.hide()

func update():
	if item_slot:
		item_texture.texture = item_slot.items[0].texture_2d
		if item_slot.items[0] is ToolItem:
			count_label.hide()
			durability_bar.max_value = (item_slot.items[0] as ToolItem).max_durability
			durability_bar.value = (item_slot.items[0] as ToolItem).durability
			durability_bar.show()
		## item_slot is a plain item
		elif item_slot.count > 1:
			count_label.text = "x" + str(item_slot.count)
		else:
			count_label.text = ""
		show()
	else:
		item_texture.texture = null
		count_label.text = ""
		hide()
