extends Control

@export var blueprint_screen: BlueprintScreen

var dragging := false
var drag_offset := Vector2.ZERO

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var layer := blueprint_screen.selected_layer
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and not dragging:
			var local_mouse_pos := layer.get_local_mouse_position()
			var cell := layer.local_to_map(local_mouse_pos)
			var tile := blueprint_screen.tiles[blueprint_screen.selected_tile_index]
			layer.set_cell(cell, tile.id, tile.atlas_coordinate)

		if event.button_index == MOUSE_BUTTON_MIDDLE:
			if event.pressed:
				dragging = true
				drag_offset = get_global_mouse_position() - position
			else:
				dragging = false
				
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed and not dragging:
			var local_mouse_pos := layer.get_local_mouse_position()
			var cell := layer.local_to_map(local_mouse_pos)
			layer.set_cell(cell, Utils.TileSetIDs.Natural, Vector2i(-1,-1))

	elif event is InputEventMouseMotion and dragging:
		position = get_global_mouse_position() - drag_offset
