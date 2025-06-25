extends Resource
class_name TileDropData

## Gridmap ID to place
@export var id: int
## The scene used to place tile if id is -2
@export var tile_to_place: PackedScene = null
@export var drop_item: Item
@export var min_drop_count: int = 1
@export var max_drop_count: int = 1
@export var tool_required: Utils.ToolType = Utils.ToolType.Pickaxe
# yes i know this is bad i was just to lazy to update all of them with a new system
@export var second_drop_item: Item
@export var second_min_drop_count: int = 1
@export var second_max_drop_count: int = 1
