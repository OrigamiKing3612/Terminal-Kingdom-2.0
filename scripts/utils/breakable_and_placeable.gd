extends GridMap
class_name BreakableGridMap

func destroy_tile(collision_point: Vector3) -> void:
	var local_point = to_local(collision_point)
	var grid_pos = local_to_map(local_point)
	if grid_pos.y <= 0:
		return
	var id = get_cell_item(grid_pos)
	var can_replace = Utils.break_tile(id)
	if can_replace:
		set_cell_item(grid_pos, -1)

func destroy_tile_scene(tile_id: int) -> void:
	var can_replace = Utils.break_tile(tile_id)
	if can_replace:
		queue_free()

func place_tile(collision_point: Vector3, tile_id: int) -> void:
	var tile_data := TileDB.get_tile(tile_id)
	if tile_data == null:
		push_error("No tile for ID %s" % tile_id)
		return

	var local_point = to_local(collision_point)
	var grid_pos = local_to_map(local_point)
	if grid_pos.y <= 0:
		return

	if tile_data.id >= 0:
		set_cell_item(grid_pos, tile_data.id, get_orthogonal_index_from_basis(Utils.vector_to_orientation(GameManager.rotation)))
	elif tile_data.id == -2 and tile_data.tile_to_place:
		var inst = tile_data.tile_to_place.instantiate()
		inst.global_position = map_to_local(grid_pos)
		get_parent().add_child(inst)
