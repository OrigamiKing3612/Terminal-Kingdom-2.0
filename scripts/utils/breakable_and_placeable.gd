extends GridMap
class_name BreakableGridMap

# Only called on gridmap, so this does not need to handle non gridmap ids
func destroy_tile(collision_point: Vector3) -> void:
	var adjusted_point = collision_point - transform.basis.y * 0.1 # push slightly inside the block
	var local_point = to_local(adjusted_point)
	var grid_pos = local_to_map(local_point)
	if grid_pos.y <= 0:
		return
	var id = get_cell_item(grid_pos)
	if id < 0:
		return

	var tile_id := TileDB.get_tile_id_from_gridmap_id(id)
	if tile_id == -1:
		push_error("No TileDropData found for mesh_id %s" % tile_id)
		return

	var can_break = Utils.break_tile(tile_id)
	if can_break:
		set_cell_item(grid_pos, -1) # Clear tile

func place_tile(collision_point: Vector3, tile_id: int) -> void:
	var tile_data := TileDB.get_tile(tile_id)
	if tile_data == null:
		push_error("No tile for ID %s" % tile_id)
		return

	var local_point := to_local(collision_point)
	var grid_pos := local_to_map(local_point)
	if grid_pos.y <= 0:
		return

	if tile_data.gridmap_id >= 0:
		set_cell_item(grid_pos, tile_data.gridmap_id, get_orthogonal_index_from_basis(Utils.vector_to_orientation(GameManager.rotation)))
	elif tile_data.scene_to_place:
		var inst = tile_data.scene_to_place.instantiate()
		if inst.has_method("when_placed"):
			inst.when_placed()
		inst.global_position = map_to_local(grid_pos)
		get_parent().add_child(inst)
