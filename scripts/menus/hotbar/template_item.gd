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
	label.visible = true
	icon.visible = true
	count_label.visible = true
	
func hide_item():
	label.visible = false
	icon.visible = false
	count_label.visible = false

func selected(): 
	label.visible = true
	
func deselected():
	label.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
