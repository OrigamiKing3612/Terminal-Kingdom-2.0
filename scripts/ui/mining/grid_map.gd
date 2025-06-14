extends GridMap

var noise := FastNoiseLite.new()
var excluded_area := Vector3(3, 2, 3)

@export var dirt_block_id: int = 4
@export var grass_block_id: int = 6
@export var stone_block_id: int = 31
@export var gold_ore_id: int = 44
@export var iron_ore_id: int = 45
@export var coal_ore_id: int = 43
@export var clay_block_id: int = 64 # mud

func _ready() -> void:
	generate_noise_area(Vector3(-32,0,-32), Vector3(64,15,64))


func _process(delta: float) -> void:
	pass


func destroy_tile(world_coordinate):
	var map_coordinate = local_to_map(world_coordinate)
	if map_coordinate.y == -2:
		return
	set_cell_item(map_coordinate, -1)
	
func generate_noise_area(origin: Vector3, size: Vector3) -> void:
	for x in range(int(origin.x), int(origin.x + size.x)):
		for z in range(int(origin.z), int(origin.z + size.z)):
			var height = int(noise.get_noise_2d(x, z) * 3) + size.y

			for y in range(int(origin.y), height):
				var pos = Vector3i(x, y, z)
				#if is_in_excluded_area(pos):
					#continue

				var block_id = stone_block_id

				if y < size.y - 12:
					# Deepest: chance for gold
					if randi() % 100 < 5:  # 5% chance
						block_id = gold_ore_id
					elif randi() % 100 < 15:  # 15% chance
						block_id = iron_ore_id
					elif randi() % 100 < 25:  # 25% chance
						block_id = coal_ore_id
				elif y < size.y - 7:
					# Medium: iron and coal
					if randi() % 100 < 10:
						block_id = iron_ore_id
					elif randi() % 100 < 20:
						block_id = coal_ore_id
				elif y < size.y:
					# Shallow: clay pockets
					if randi() % 100 < 10:
						block_id = clay_block_id

				set_cell_item(pos, block_id, 0)

			# Top layer: grass
			var pos = Vector3i(x, height, z)
			#if not is_in_excluded_area(pos):
				#set_cell_item(pos, dirt_block_id, 0)
			
func is_in_excluded_area(pos: Vector3i) -> bool:
	return pos.x >= -3 and pos.x <= excluded_area.x and pos.z >= -2 and pos.z <= excluded_area.z
