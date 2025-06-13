extends GridMap

@export var dirt_block_id := 1
@export var grass_block_id := 2
@export var area_size := Vector3(16, 4, 16)

var noise := FastNoiseLite.new()

func destroy_tile(world_coordinate):
	var map_coordinate = local_to_map(world_coordinate)
	if map_coordinate.y == -2:
		return
	set_cell_item(map_coordinate, -1)
	
func place_tile(world_coordinate, block_index: int):
	var map_coordinate = local_to_map(world_coordinate)
	set_cell_item(map_coordinate, block_index)

func _ready():
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = 0.1
	noise.fractal_octaves = 4
	noise.fractal_gain = 0.5
	noise.fractal_lacunarity = 2.0

	var origin = Vector3(5, 0, 5)  # Change this to where you want the patch
	generate_noise_area(origin, area_size)

func generate_noise_area(origin: Vector3, size: Vector3) -> void:
	for x in range(int(origin.x), int(origin.x + size.x)):
		for z in range(int(origin.z), int(origin.z + size.z)):
			var height = int(noise.get_noise_2d(x, z) * 3) + 2

			for y in range(int(origin.y), height):
				var pos = Vector3i(x, y, z)
				if is_in_excluded_area(pos):
					continue
				set_cell_item(pos, dirt_block_id, 0)

			var pos = Vector3i(x, height, z)
			if not is_in_excluded_area(pos):
				set_cell_item(pos, grass_block_id, 0)
			
func is_in_excluded_area(pos: Vector3i) -> bool:
	return pos.x >= 10 and pos.x <= 15 and pos.z >= 10 and pos.z <= 15
