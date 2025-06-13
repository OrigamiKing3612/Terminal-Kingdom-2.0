class_name HotbarTemplateItem
extends Panel

@export var item: Item
@export var count: int

@onready var label: RichTextLabel = $TemplateLabel
@onready var icon: TextureRect = $TemplateIcon
@onready var count_label: RichTextLabel = $TemplateCountLabel

func _ready() -> void:
	update_display()

func update_display() -> void:
	if not item:
		hide()
		return
	label.text = item.name
	icon.texture = item.texture_2d
	count_label.text = "x%d" % count
	show_item()

func show_item():
	self.visible = true
	
func hide_item():
	self.visible = false

func selected(): 
	label.visible = true
	self.modulate.a = 0.8
	
func deselected():
	label.visible = false
	self.modulate.a = 0.2
