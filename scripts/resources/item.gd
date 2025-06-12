class_name Item extends Resource

@export var name: String = ""
@export var price: int = 10
@export var can_be_sold: bool = true
@export var is_buildable: bool = false

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
