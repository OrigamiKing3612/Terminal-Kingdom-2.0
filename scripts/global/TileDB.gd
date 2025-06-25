extends Node

# [int, TileDropData or String], tile_id, loaded item or path to item
var tiles: Dictionary = {}

func get_tile(id: int) -> TileDropData:
	if tiles.has(id):
		if tiles[id] is String:
			tiles[id] = load(tiles[id]) as TileDropData
		return tiles[id] as TileDropData
	push_warning("no tile in TileDB for id: ", id)
	return null

func _ready():
	const FOLDER_PATH = "res://assets/resources/drops/"
	const MESH_LIBRARY = FOLDER_PATH + "tile_drops/MeshLibrary/"
	tiles[0] = MESH_LIBRARY + "brick/dirt_slope_drop.tres"
	tiles[1] = MESH_LIBRARY + "brick/dirt_stair_exterior_corner_drop.tres"
	tiles[2] = MESH_LIBRARY + "brick/dirt_stair_interior_corner_drop.tres"
	tiles[3] = MESH_LIBRARY + "brick/dirt_stairs_drop.tres"
	tiles[4] = MESH_LIBRARY + "brick/dirt_drop.tres"
	tiles[5] = MESH_LIBRARY + "grass/grass_slope_drop.tres"
	tiles[6] = MESH_LIBRARY + "grass/grass_drop.tres"
	tiles[7] = MESH_LIBRARY + "brick/brick_slope_drop.tres"
	tiles[8] = MESH_LIBRARY + "brick/brick_stair_exterior_corner_drop.tres"
	tiles[9] = MESH_LIBRARY + "brick/brick_stair_interior_corner_drop.tres"
	tiles[10] = MESH_LIBRARY + "brick/brick_stairs_drop.tres"
	tiles[11] = MESH_LIBRARY + "brick/bricks_drop.tres"
	tiles[12] = MESH_LIBRARY + "brick/brick_wall_drop.tres"
	tiles[13] = MESH_LIBRARY + "marble/marble_slope_drop.tres"
	tiles[14] = MESH_LIBRARY + "marble/marble_stair_exterior_corner_drop.tres"
	tiles[15] = MESH_LIBRARY + "marble/marble_stair_interior_corner_drop.tres"
	tiles[16] = MESH_LIBRARY + "marble/marble_stairs_drop.tres"
	tiles[17] = MESH_LIBRARY + "marble/marble_drop.tres"
	tiles[18] = MESH_LIBRARY + "marble/marble_wall_drop.tres"
	tiles[19] = MESH_LIBRARY + "marble/brick/marble_brick_slope_drop.tres"
	tiles[20] = MESH_LIBRARY + "marble/brick/marble_brick_stair_exterior_corner_drop.tres"
	tiles[21] = MESH_LIBRARY + "marble/brick/marble_brick_stair_interior_corner_drop.tres"
	tiles[22] = MESH_LIBRARY + "marble/brick/marble_brick_stairs_drop.tres"
	tiles[23] = MESH_LIBRARY + "marble/brick/marble_brick_drop.tres"
	tiles[24] = MESH_LIBRARY + "marble/brick/marble_brick_wall_drop.tres"
	tiles[25] = MESH_LIBRARY + "wood/lumber/log_slope_drop.tres"
	tiles[26] = MESH_LIBRARY + "wood/lumber/log_drop.tres"
	tiles[27] = MESH_LIBRARY + "stone/stone_slope_drop.tres"
	tiles[28] = MESH_LIBRARY + "stone/stone_stair_exterior_corner_drop.tres"
	tiles[29] = MESH_LIBRARY + "stone/stone_stair_interior_corner_drop.tres"
	tiles[30] = MESH_LIBRARY + "stone/stone_stairs_drop.tres"
	tiles[31] = MESH_LIBRARY + "stone/stone_drop.tres"
	tiles[32] = MESH_LIBRARY + "stone/stone_wall_drop.tres"
	tiles[33] = MESH_LIBRARY + "stone/brick/stone_brick_slope_drop.tres"
	tiles[34] = MESH_LIBRARY + "stone/brick/stone_brick_stair_exterior_corner_drop.tres"
	tiles[35] = MESH_LIBRARY + "stone/brick/stone_brick_stair_interior_corner_drop.tres"
	tiles[36] = MESH_LIBRARY + "stone/brick/stone_brick_stairs_drop.tres"
	tiles[37] = MESH_LIBRARY + "stone/brick/stone_bricks_drop.tres"
	tiles[38] = MESH_LIBRARY + "stone/brick/stone_brick_wall_drop.tres"
	tiles[39] = MESH_LIBRARY + "sand/sand_drop.tres"
	tiles[40] = MESH_LIBRARY + "sand/sand_slope_drop.tres"
	#tiles[41] = null # Water Tile
	tiles[42] = MESH_LIBRARY + "item/coin_item_drop.tres"
	tiles[43] = MESH_LIBRARY + "item/coal_item_drop.tres"
	tiles[44] = MESH_LIBRARY + "item/gold_item_drop.tres"
	tiles[45] = MESH_LIBRARY + "item/iron_item_drop.tres"
	tiles[46] = MESH_LIBRARY + "item/lumber.tres"
	tiles[47] = MESH_LIBRARY + "item/lumber.tres"
	tiles[48] = MESH_LIBRARY + "item/lumber.tres"
	tiles[49] = MESH_LIBRARY + "item/stone_item_drop.tres"
	tiles[50] = MESH_LIBRARY + "stone/rough/rough_stone_drop.tres"
	tiles[51] = MESH_LIBRARY + "stone/rough/rough_stone_slope_drop.tres"
	tiles[52] = MESH_LIBRARY + "stone/rough/rough_stone_wall_drop.tres"
	tiles[53] = MESH_LIBRARY + "stone/rough/rough_stone_stair_interior_corner_drop.tres"
	tiles[54] = MESH_LIBRARY + "stone/rough/rough_stone_stair_drop.tres"
	tiles[55] = MESH_LIBRARY + "stone/rough/rough_stone_stair_exterior_corner_drop.tres"
	tiles[56] = MESH_LIBRARY + "stone/polished/polished_stone_drop.tres"
	tiles[57] = MESH_LIBRARY + "stone/polished/polished_stone_stair_interior_corner_drop.tres"
	tiles[58] = MESH_LIBRARY + "stone/polished/polished_stone_stair_drop.tres"
	tiles[59] = MESH_LIBRARY + "stone/polished/polished_stone_stair_exterior_corner_drop.tres"
	tiles[60] = MESH_LIBRARY + "stone/polished/polished_stone_slope_drop.tres"
	tiles[61] = MESH_LIBRARY + "stone/polished/polished_stone_wall_drop.tres"
	tiles[62] = MESH_LIBRARY + "stone/polished/polished_stone_pole_drop.tres"
	tiles[63] = MESH_LIBRARY + "mud/mud_slope_drop.tres"
	tiles[64] = MESH_LIBRARY + "mud/mud_drop.tres"
	tiles[65] = MESH_LIBRARY + "tree/tree_drop.tres"
	tiles[66] = MESH_LIBRARY + "tree/tree_small_drop.tres"
	tiles[67] = FOLDER_PATH + "tile_drops/building_mains/furnace_drop.tres"
	tiles[68] = FOLDER_PATH + "tile_drops/building_mains/governors_desk_drop.tres"
	tiles[69] = FOLDER_PATH + "tile_drops/building_mains/medical_table_drop.tres"
	tiles[70] = FOLDER_PATH + "tile_drops/building_mains/miners_crate_drop.tres"
	tiles[71] = FOLDER_PATH + "tile_drops/building_mains/potters_wheel_drop.tres"
	tiles[72] = FOLDER_PATH + "tile_drops/building_mains/saw_table_drop.tres"
	tiles[73] = FOLDER_PATH + "tile_drops/building_mains/scarecrow_drop.tres"
	tiles[74] = FOLDER_PATH + "tile_drops/building_mains/target_drop.tres"
	tiles[75] = FOLDER_PATH + "tile_drops/building_mains/tavern_tile_drop.tres"
	tiles[76] = FOLDER_PATH + "tile_drops/building_mains/throne_drop.tres"
	tiles[77] = FOLDER_PATH + "tile_drops/building_mains/workbench_drop.tres"
	tiles[78] = FOLDER_PATH + "tile_drops/extra/pot_drop.tres"
	tiles[79] = FOLDER_PATH + "tile_drops/extra/anvil_drop.tres"
	tiles[80] = FOLDER_PATH + "tile_drops/extra/mine_entrance_drop.tres"
	
func get_tile_id_from_gridmap_id(gridmap_id: int) -> int:
	for i in TileDB.tiles.size():
		var tile = TileDB.get_tile(i)
		if not tile:
			push_warning("no tile data found for gridmap_id: ", gridmap_id)
			continue
		if tile.gridmap_id == gridmap_id:
			return tile.tile_id
	return -1
