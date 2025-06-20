extends Item
class_name ToolItem 

#@export_group("Tool Settings")
@export var durability: int = 55
@export var broken_texture_2d: Texture2D = preload("res://assets/models/icons/bricks_preview.tres")

@export_group("Tags")
@export var tool_type: Utils.ToolType = Utils.ToolType.Pickaxe

func remove_durability(count: int = 1):
	durability -= count
	if durability <= 0:
		GameManager.player.removeItem(id)
	emit_changed()
