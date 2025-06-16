extends GridMap
class_name BreakableGridMap
@export var drop: Item = preload("res://assets/resources/items/tiles/lumber.tres")

func destroy_tile(collision_point: Vector3) -> void:
	var local_point = to_local(collision_point)
	var grid_pos = local_to_map(local_point)
	if grid_pos.y == 0:
		return
	var id = get_cell_item(grid_pos)
	if id == 65:
		GameManager.player.collectItem(drop, GameManager.random.randi_range(1, 3))
	elif id == 66:
		GameManager.player.collectItem(drop, 1)
	set_cell_item(grid_pos, -1)

func place_tile(collision_point: Vector3, block_index: int) -> void:
	var local_point = to_local(collision_point)
	var grid_pos = local_to_map(local_point)
	if grid_pos.y == 0:
		return
	set_cell_item(grid_pos, block_index)
