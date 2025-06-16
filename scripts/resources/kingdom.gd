extends Resource
class_name Kingdom

@export var name: String = "Default Kingdom Name"
@export var castle_location: Vector3
@export var villages: Dictionary[String, Village] = {}

func add_village(village: Village):
	villages[village.id] = village

func remove_village(id: String):
	villages.erase(id)
