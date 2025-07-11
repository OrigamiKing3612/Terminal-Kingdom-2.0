extends Resource
class_name Plant

@export var scene: PackedScene
@export var growth_time: float = 10 # seconds
@export var harvest_item: Item
@export var min_amount: int = 1
@export var max_amount: int = 1

enum Stage{
	seed, sprout, mature
}
