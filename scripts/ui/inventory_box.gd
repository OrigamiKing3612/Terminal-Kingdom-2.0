extends CanvasLayer

@onready var texture_rect: TextureRect = $Control/TextureRect
@onready var inventory_label: RichTextLabel = $Control/InventoryLabel
@onready var items: Control = $Control/Items

func show_item(item: Item) -> TextureButton:
	var button := TextureButton.new()
	button.texture_normal = item.texture_2d
	button.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
	button.custom_minimum_size = Vector2(32, 32)
	button.position = item.position_in_inventory
	button.tooltip_text = item.name
	
	button.set_script(preload("res://scripts/ui/DraggableItem.gd"))

	return button

func _on_show_inventory() -> void:
	for item in GameManager.player.items:
		var button = show_item(item)
		items.add_child(button)

func _on_hide_inventory() -> void:
	for child in items.get_children():
		child.queue_free()
