extends Control
class_name ToolbeltNode

const INVENTORY_ITEM = preload("res://scenes/ui/inventory/inventory_item.tscn")

@onready var grid_container: GridContainer = $Panel/GridContainer

var selected_toolbelt_slot: int = 0
var toolbelt_slots: Array[ToolbeltInventorySlot] = []

var selected_item: Item:
	get:
		var item := toolbelt_slots[selected_toolbelt_slot].inventory_item
		if item:
			if item.item_slot:
				return item.item_slot.items[0]
		return null

func _ready() -> void:
	for child in grid_container.get_children():
		if child is ToolbeltInventorySlot:
			toolbelt_slots.append(child)

	_update_slots()

func _on_show_inventory() -> void:
	show()

func _on_hide_inventory() -> void:
	var all_empty := true
	for slot in toolbelt_slots:
		if not slot.is_empty():
			all_empty = false
			break
	if all_empty:
		hide()

func _update_slots() -> void:
	selected_toolbelt_slot = clampi(selected_toolbelt_slot, 0, toolbelt_slots.size() - 1)

	for i in toolbelt_slots.size():
		if i == selected_toolbelt_slot:
			toolbelt_slots[i].selected()
		else:
			toolbelt_slots[i].deselected()

func _on_toolbelt_next() -> void:
	selected_toolbelt_slot += 1
	if selected_toolbelt_slot >= toolbelt_slots.size():
		selected_toolbelt_slot = 0
	_update_slots()

func _on_toolbelt_back() -> void:
	selected_toolbelt_slot -= 1
	if selected_toolbelt_slot < 0:
		selected_toolbelt_slot = toolbelt_slots.size() - 1
	_update_slots()
