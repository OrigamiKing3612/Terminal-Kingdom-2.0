extends Resource
class_name TileDropData

@export var tile_id: int = -1
@export var gridmap_id: int = -1
@export var scene_to_place: PackedScene
@export var drop_item: Item
@export var min_drop_count: int = 1
@export var max_drop_count: int = 1
@export var tool_required: Utils.ToolType = Utils.ToolType.Pickaxe
@export var second_drop_item: Item
@export var second_min_drop_count: int = 1
@export var second_max_drop_count: int = 1
