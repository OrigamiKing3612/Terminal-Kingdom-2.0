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

func place_tile(collision_point: Vector3, block_index: int) -> void:
	var local_point = to_local(collision_point)
	var grid_pos = local_to_map(local_point)
	if grid_pos.y <= 0:
		return
		
	var basis = Basis()
	basis = basis.rotated(Vector3.RIGHT, deg_to_rad(GameManager.rotation.x))
	basis = basis.rotated(Vector3.UP, deg_to_rad(GameManager.rotation.y))
	basis = basis.rotated(Vector3.FORWARD, deg_to_rad(GameManager.rotation.z))

	var orientation = get_orthogonal_index_from_basis(basis)
	set_cell_item(grid_pos, block_index, orientation)
