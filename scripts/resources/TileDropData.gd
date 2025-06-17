extends Resource
class_name TileDropData

@export var id: int
@export var drop_item: Item
@export var min_drop_count: int = 1
@export var max_drop_count: int = 1
@export var tool_required: Utils.ToolType = Utils.ToolType.Pickaxe
