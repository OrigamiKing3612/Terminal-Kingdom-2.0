extends Panel
class_name HotBar

@export var items: Array[Item]
@export var template_item: PackedScene = preload("res://scenes/menus/hotbar/template_item.tscn")
@onready var container: Node = $Items

var selected_item_index: int:
	get:
		return GameManager.selected_tile_index
	set(value):
		GameManager.selected_tile_index = value
func _ready() -> void:
	pass

func show_hot_bar():
	if not items.size() > 0:
		print("No items")
		return
		
	var size = items.size()
	var last = (selected_item_index - 1 + size) % size
	var last2 = (selected_item_index - 2 + size) % size
	var next = (selected_item_index + 1) % size
	var next2 = (selected_item_index + 2) % size

	var indices = [last2, last, selected_item_index, next, next2]

	for i in indices:
		var new_item: HotbarTemplateItem = template_item.instantiate()
		new_item.item = items[i]
		new_item.count = 10
		new_item.position = Vector2(64, 128 * 2)
		new_item.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
		
		container.add_child(new_item)
		new_item.update_display()
	
	
func hide_hot_bar():
	selected_item_index = 0
	for child in container.get_children():
		child.queue_free()
	
func last_index() -> int:
	return items.size() - 1

#func _input(event: InputEvent) -> void:
	#if !(event.is_pressed() and not event.is_echo()):
		#return
	#if not buildable_items.is_visible():
		#return
#
	#var selected := buildable_items.get_selected_items()
	#var index := selected[0] if selected.size() > 0 else -1
#
	#if Input.is_action_just_pressed("scroll_down"):
		#index += 1
		#if index >= buildable_items.item_count:
			#index = 0
		#buildable_items.select(index)
		#GameManager.selected_tile = items[index].gridmap_id
#
	#if Input.is_action_just_pressed("scroll_up"):
		#index -= 1
		#if index < 0:
			#index = buildable_items.item_count - 1
		#buildable_items.select(index)
		#GameManager.selected_tile = items[index].gridmap_id
