extends Panel
class_name HotBar

@export var items: Array[Item]
@export var template_item: PackedScene = preload("res://scenes/menus/hotbar/template_item.tscn")
@onready var container: Node = $Items
var buildable_items: Array[Item] = []

var selected_item_index: int:
	get: return GameManager.selected_item_index
	set(value): GameManager.selected_item_index = value

func show_hot_bar():
	if buildable_items.is_empty():
		print("No buildable items")
		return

	for child in container.get_children():
		child.queue_free()

	var size = buildable_items.size()
	var last = (selected_item_index - 1 + size) % size
	var last2 = (selected_item_index - 2 + size) % size
	var next = (selected_item_index + 1) % size
	var next2 = (selected_item_index + 2) % size

	var indices = [last2, last, selected_item_index, next, next2]

	for display_slot in indices.size():
		var item_index = indices[display_slot]
		var new_item: HotbarTemplateItem = template_item.instantiate()
		new_item.item = buildable_items[item_index]
		new_item.count = 10

		new_item.anchor_left = 0
		new_item.anchor_top = 1
		new_item.anchor_right = 0
		new_item.anchor_bottom = 1

		new_item.position = Vector2(64, -128 * display_slot)

		container.add_child(new_item)
		new_item.update_display()

		if item_index == selected_item_index:
			new_item.selected()
			GameManager.selected_gridmap_id = buildable_items[item_index].gridmap_id
		else:
			new_item.deselected()

func _unhandled_input(event: InputEvent) -> void:
	if buildable_items.is_empty():
		return

	if Input.is_action_just_pressed("next_option"):
		selected_item_index = (selected_item_index + 1) % buildable_items.size()
		show_hot_bar()
	elif Input.is_action_just_pressed("back_option"):
		selected_item_index = (selected_item_index - 1 + buildable_items.size()) % buildable_items.size()
		show_hot_bar()

func hide_hot_bar():
	selected_item_index = 0
	for child in container.get_children():
		child.queue_free()
