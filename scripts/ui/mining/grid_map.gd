extends TileMapLayer

var noise := FastNoiseLite.new()
var excluded_area := Vector2i(3, 2)

@export var dirt_tile: Item
@export var stone_tile: Item
@export var gold_ore: Item
@export var iron_ore: Item
@export var coal_ore: Item
@export var clay_tile: Item

func _ready() -> void:
	GameManager.stop_mining.connect(_on_stop_mining)
	var size: Vector2i
	if GameManager.player.mining_level == 1:
		size = Vector2i(64,3)
	else:
		size = Vector2i(64,1)
	generate_noise_area(Vector2i(-32,0), size)
	dirt_tile = dirt_tile.copy()
	stone_tile = stone_tile.copy()
	gold_ore = gold_ore.copy()
	iron_ore = iron_ore.copy()
	coal_ore = coal_ore.copy()
	clay_tile = clay_tile.copy()

func _on_stop_mining():
	SceneManager.go_back()
	GameManager.mode = GameManager.Mode.Normal

#func destroy_tile(collision_point: Vector2) -> void:
	#var local_point = to_local(collision_point)
	#var grid_pos = local_to_map(local_point)
	#grid_pos.y = int(floor((local_point.y - 0.01) / 16))
	#if grid_pos.y <= 0:
		#return
	#var id = set_cell(grid_pos)
	#if id < 0:
		#return
	#var can_replace = Utils.break_tile(id)
	#if can_replace:
		#set_cell(grid_pos, -1)
	
func generate_noise_area(origin: Vector2i, size: Vector2i) -> void:
	for x in range(origin.x, origin.x + size.x):
		for z in range(origin.x, size.x):
			var height = noise.get_noise_2d(x, z) * 3 + size.y

			for y in range(origin.y, height):
				var pos = Vector2i(x, y)
				#if is_in_excluded_area(pos):
					#continue

				var block_id = stone_tile.tile_id

				if y < size.y - 12:
					# Deepest: chance for gold
					if randi() % 100 < 5:  # 5% chance
						block_id = gold_ore.tile_id
					elif randi() % 100 < 15:  # 15% chance
						block_id = iron_ore.tile_id
					elif randi() % 100 < 25:  # 25% chance
						block_id = coal_ore.tile_id
				elif y < size.y - 7:
					# Medium: iron and coal
					if randi() % 100 < 10:
						block_id = iron_ore.tile_id
					elif randi() % 100 < 20:
						block_id = coal_ore.tile_id
				elif y < size.y:
					# Shallow: clay pockets
					if randi() % 100 < 10:
						block_id = clay_tile.tile_id

				set_cell(pos, block_id)

			# Top layer: grass
			#var pos = Vector2i(x, height, z)
			#if not is_in_excluded_area(pos):
				#set_cell_item(pos, dirt_block_id, 0)
			
func is_in_excluded_area(pos: Vector2i) -> bool:
	return pos.x >= -3 and pos.x <= excluded_area.x and pos.y >= -2 and pos.y <= excluded_area.y
