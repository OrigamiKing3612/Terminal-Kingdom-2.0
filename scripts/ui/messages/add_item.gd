extends Control

@export var item: Item
@onready var rich_text_label: RichTextLabel = $MarginContainer/AddItem/RichTextLabel
@onready var sprite_2d: Sprite2D = $MarginContainer/AddItem/Control/Sprite2D

func init(item: Item, type: Utils.CollectedItemType) -> void:
	self.item = item
	sprite_2d.texture = item.texture_2d
	rich_text_label.text = item.name
	
