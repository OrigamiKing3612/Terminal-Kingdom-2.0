class_name Item extends Resource

# Every tile must have an item resource to be in inventory
var id: String
@export var name: StringName = ""
@export var price: int = 10
@export var can_be_sold: bool = true
@export var is_buildable: bool = false
@export var texture_2d: Texture2D = preload("res://assets/models/icons/bricks_preview.tres")
@export var max_amount_per_stack: int = 50

@export_group("Buildable Settings")
@export var gridmap_id: int = 0
@export var scene_to_place: PackedScene = null

@export_group("Tags")
@export var seed: Utils.SeedType = Utils.SeedType.None

func _init():
	id = UUID.string()
	
func copy() -> Item:
	var new = duplicate()
	new.id = UUID.string()
	return new
