extends CanvasLayer

@onready var buildable_items: ItemList = $BuildableItems

var items: Array[Item] = []

func _on_show_building() -> void:
	items.clear()
	buildable_items.clear()
	
	for item in GameManager.player.items:
		if item.is_buildable:
			buildable_items.add_item(item.name, item.texture_2d, true)
			items.append(item)

	if items.size() > 0:
		buildable_items.select(0)
		GameManager.selected_tile = items[0].gridmap_id

func _input(event: InputEvent) -> void:
	if !(event.is_pressed() and not event.is_echo()):
		return
	if not buildable_items.is_visible():
		return

	var selected := buildable_items.get_selected_items()
	var index := selected[0] if selected.size() > 0 else -1

	if Input.is_action_just_pressed("scroll_down"):
		index += 1
		if index >= buildable_items.item_count:
			index = 0
		buildable_items.select(index)
		GameManager.selected_tile = items[index].gridmap_id

	if Input.is_action_just_pressed("scroll_up"):
		index -= 1
		if index < 0:
			index = buildable_items.item_count - 1
		buildable_items.select(index)
		GameManager.selected_tile = items[index].gridmap_id

func _on_hide_building() -> void:
	pass
