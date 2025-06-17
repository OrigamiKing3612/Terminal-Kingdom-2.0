extends GridMap

var noise := FastNoiseLite.new()
var excluded_area := Vector3i(3, 2, 3)

@export var dirt_tile: Item
@export var stone_tile: Item
@export var gold_ore: Item
@export var iron_ore: Item
@export var coal_ore: Item
@export var clay_tile: Item

func _ready() -> void:
	GameManager.stop_mining.connect(_on_stop_mining)
	var size: Vector3i
	if GameManager.player.mining_level == 1:
		size = Vector3i(64,3,64)
	else:
		size = Vector3i(64,15,64)
	generate_noise_area(Vector3i(-32,0,-32), size)
	dirt_tile = dirt_tile.copy()
	stone_tile = stone_tile.copy()
	gold_ore = gold_ore.copy()
	iron_ore = iron_ore.copy()
	coal_ore = coal_ore.copy()
	clay_tile = clay_tile.copy()

func _on_stop_mining():
	SceneManager.go_back()
	GameManager.mode = GameManager.Mode.Normal

func destroy_tile(world_coordinate):
	var map_coordinate = local_to_map(world_coordinate)
	if map_coordinate.y == 0:
		return
	set_cell_item(map_coordinate, -1)
	
func generate_noise_area(origin: Vector3i, size: Vector3i) -> void:
	for x in range(origin.x, origin.x + size.x):
		for z in range(origin.z, origin.z + size.z):
			var height = noise.get_noise_2d(x, z) * 3 + size.y

			for y in range(origin.y, height):
				var pos = Vector3i(x, y, z)
				#if is_in_excluded_area(pos):
					#continue

				var block_id = stone_tile.gridmap_id

				if y < size.y - 12:
					# Deepest: chance for gold
					if randi() % 100 < 5:  # 5% chance
						block_id = gold_ore.gridmap_id
					elif randi() % 100 < 15:  # 15% chance
						block_id = iron_ore.gridmap_id
					elif randi() % 100 < 25:  # 25% chance
						block_id = coal_ore.gridmap_id
				elif y < size.y - 7:
					# Medium: iron and coal
					if randi() % 100 < 10:
						block_id = iron_ore.gridmap_id
					elif randi() % 100 < 20:
						block_id = coal_ore.gridmap_id
				elif y < size.y:
					# Shallow: clay pockets
					if randi() % 100 < 10:
						block_id = clay_tile.gridmap_id

				set_cell_item(pos, block_id, 0)

			# Top layer: grass
			#var pos = Vector3i(x, height, z)
			#if not is_in_excluded_area(pos):
				#set_cell_item(pos, dirt_block_id, 0)
			
func is_in_excluded_area(pos: Vector3i) -> bool:
	return pos.x >= -3 and pos.x <= excluded_area.x and pos.z >= -2 and pos.z <= excluded_area.z
