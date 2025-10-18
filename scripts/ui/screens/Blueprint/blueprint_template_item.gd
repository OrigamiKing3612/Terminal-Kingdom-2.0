extends Panel
class_name BlueprintHotbarTemplateItem

@export var display_name: String
@export var display_icon: Texture2D

@onready var label: RichTextLabel = $TemplateLabel
@onready var icon: TextureRect = $TemplateIcon

func _ready() -> void:
	update_display()

func update_display() -> void:
	label.text = display_name
	icon.texture = display_icon
	show_item()

func show_item():
	self.visible = true
	
func hide_item():
	self.visible = false

func selected(): 
	#icon.visible = true
	label.visible = true
	self.modulate.a = 0.8
	
func deselected():
	#icon.visible = false
	label.visible = false
	self.modulate.a = 0.2
