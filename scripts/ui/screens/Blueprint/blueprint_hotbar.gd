extends Panel
class_name BlueprintHotBar

@export var template_item: PackedScene = preload("res://scenes/ui/screens/Blueprint/blueprint_template_item.tscn")
@onready var container: Node = $Items
@export var blueprint_screen: BlueprintScreen

var selected_item_index: int:
	get: return blueprint_screen.selected_tile_index
	set(newValue):
		blueprint_screen.selected_tile_index = newValue
var buildable_items: Array[TileOption]:
	get: return blueprint_screen.tiles

func show_hot_bar():
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
		var new_item: BlueprintHotbarTemplateItem = template_item.instantiate()
		new_item.display_name = buildable_items[item_index].display_name
		new_item.display_icon = buildable_items[item_index].display_icon
		new_item.anchor_left = 0
		new_item.anchor_top = 1
		new_item.anchor_right = 0
		new_item.anchor_bottom = 1

		new_item.position = Vector2(64, (-128 * (display_index)) - 85)

		container.add_child(new_item)
		new_item.update_display()

		if display_index == 2:  # always select the middle one in the visible list
			new_item.selected()
			blueprint_screen.selected_tile_index = item_index
		else:
			new_item.deselected()

func hide_hot_bar():
	clear_children()

func clear_children():
	for child in container.get_children():
		container.remove_child(child)
		child.free()

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
