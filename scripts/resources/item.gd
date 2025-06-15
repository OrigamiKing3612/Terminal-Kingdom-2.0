class_name Item extends Resource

@export var name: String = ""
@export var price: int = 10
@export var can_be_sold: bool = true
@export var is_buildable: bool = false
@export var texture_2d: Texture2D = preload("res://assets/models/icons/bricks_preview.tres")
@export var position_in_inventory: Vector2 = Vector2(100, 100)

@export_group("Buildable Settings")
@export var gridmap_id: int = 0

@export_group("Generate Settings")
@export var generate_item: bool = true
@export var generate_preview: bool = false
@export var preview_file: String = ""
@export var override_name: bool = false
@export var overriden_name: String = ""

#enum ItemType{
	#sword, axe, pickaxe, boomerang, # bow? net? dagger?
	#backpack,
	#lumber,
	#iron,
	#coal,
	#gold,
	#stone,
	#clay,
	#tree_seed,
	#stick,
	#steel,
	#door,
	#fence,
	#gate,
	#chest,
	#bed,
	#desk,
	#coin,
	#carrot,
	#potato,
	#wheat,
	#lettuce,
	#pot,
#}
