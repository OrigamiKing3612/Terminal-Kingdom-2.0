extends Control
class_name ToolbeltNode

const INVENTORY_ITEM = preload("res://scenes/ui/inventory/inventory_item.tscn")

@onready var grid_container: GridContainer = $Panel/GridContainer

var toolbelt_slots: Array[ToolbeltInventorySlot] = []

func _ready() -> void:
	for child in grid_container.get_children():
		if child is ToolbeltInventorySlot:
			toolbelt_slots.append(child)

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
