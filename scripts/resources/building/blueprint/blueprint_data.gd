extends Resource
class_name BlueprintData

var id = UUID.string()
@export var name: String
@export var data: Dictionary[Utils.BuildingSide, BlueprintSide] = {}
@export var is_built_in: bool = false

func extract_data_from_layer(layer: TileMapLayer) -> BlueprintSide:
	var blueprint_side := BlueprintSide.new()
	
	for pos in layer.get_used_cells():
		var tile := BlueprintTile.new()
		tile.position = pos
		tile.source_id = layer.get_cell_source_id(pos)
		tile.atlas_coordinates = layer.get_cell_atlas_coords(pos)
		
		blueprint_side.data.append(tile)
	return blueprint_side
