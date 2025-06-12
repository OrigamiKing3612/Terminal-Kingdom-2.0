extends CanvasLayer

@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var sprite_2d: Sprite2D = $VBoxContainer/Sprite2D
@onready var inventory_label: RichTextLabel = $VBoxContainer/InventoryLabel

func show_item(item: String, count: int) -> RichTextLabel:
	var label = RichTextLabel.new()
	label.text = "%s x%d" % [name, count]
	return label

func _on_show_inventory() -> void:
	var inventory_items: Dictionary = {}
	
	for item in GameManager.player.items:
		if inventory_items.has(item.name):
			inventory_items[item.name] += 1
		else:
			inventory_items[item.name] = 1
	
	for name in inventory_items:
		var label = show_item(name, inventory_items[name])
		v_box_container.add_child(label)

func _on_hide_inventory() -> void:
	var keep = [sprite_2d, inventory_label]
	for child in v_box_container.get_children():
		if child not in keep:
			child.queue_free()
