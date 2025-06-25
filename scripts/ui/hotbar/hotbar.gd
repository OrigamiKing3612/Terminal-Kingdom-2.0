extends Panel
class_name HotBar

@export var template_item: PackedScene = preload("res://scenes/ui/hotbar/template_item.tscn")
@onready var container: Node = $Items
var buildable_items: Array[InventoryItemSlot]

var selected_item_index: int:
	get: return GameManager.selected_item_index
	set(value): 
		GameManager.selected_item_index = value

func show_hot_bar():	
	if GameManager.player.inventory.get_items().size() == 0:
		print("No items")
		return
	if buildable_items.size() == 0:
		print("No buildable items")
		return

	clear_children()

	var size = buildable_items.size()
	var last2 = (selected_item_index - 2 + size) % size
	var last = (selected_item_index - 1 + size) % size
	var next = (selected_item_index + 1) % size
	var next2 = (selected_item_index + 2) % size

	var indices = [last2, last, selected_item_index, next, next2]

	for display_index in range(indices.size()):
		var item_index = indices[display_index]
		var new_item: HotbarTemplateItem = template_item.instantiate()
		new_item.item = buildable_items[item_index].items[0]
		new_item.count = buildable_items[item_index].count
		new_item.anchor_left = 0
		new_item.anchor_top = 1
		new_item.anchor_right = 0
		new_item.anchor_bottom = 1

		new_item.position = Vector2(64, (-128 * (display_index)) - 85)

		container.add_child(new_item)
		new_item.update_display()

		if display_index == 2:  # always select the middle one in the visible list
			new_item.selected()
			GameManager.selected_tile_id = buildable_items[item_index].items[0].tile_id
		else:
			new_item.deselected()

func hide_hot_bar():
	clear_children()

func clear_children():
	for child in container.get_children():
		container.remove_child(child)
		child.free()

func refresh_buildable_items():
	buildable_items.clear()
	var buildable_count: Array[InventoryItemSlot] = []

	for slot in GameManager.player.inventory.slots:
		if slot:
			if not slot.items.is_empty():
				if slot.items[0].is_buildable:
					buildable_items.append(slot)

	for b in buildable_count:
		buildable_items.append(b)

func _on_game_manager_inventory_update() -> void:
	refresh_buildable_items()

func _on_build_next() -> void:
	if not buildable_items.size() > 1: return
	var index = selected_item_index
	index = (index + 1) % buildable_items.size()
	selected_item_index = index
	show_hot_bar()

func _on_build_back() -> void:
	if not buildable_items.size() > 1: return
	var index = selected_item_index
	index = (index - 1 + buildable_items.size()) % buildable_items.size()
	selected_item_index = index
	show_hot_bar()
