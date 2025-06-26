extends Node
class_name Kingdom

@export var kingdom_name: String = "Default Kingdom Name"
@export var castle_location: Vector3
var _villages: Dictionary[String, Village] = {}

func add_village(village: Village):
	_villages[village.id] = village
	add_child(village)

func get_village(id: String) -> Village:
	return _villages.get(id, null)

func remove_village(id: String):
	if _villages.has(id):
		var village = _villages[id]
		village.queue_free()
		_villages.erase(id)
