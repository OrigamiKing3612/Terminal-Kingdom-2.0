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

func get_villages() -> Array[Village]:
	return _villages.values()

func remove_village(id: String):
	if _villages.has(id):
		var village = _villages[id]
		village.queue_free()
		_villages.erase(id)

## Looks with a radius of 80 (40 tiles)
func find_nearby_villages(position: Vector3i, radius: float = 80.0) -> Array[Village]:
	var found: Array[Village] = []
	for village in GameManager.kingdom.get_villages():
		if position.distance_to(village.courthouse_location) < radius:
			found.append(village)
	return found

## Returns village_id
func add_building_to_closest_village(building: BuildingMainTile) -> String:
	var nearby_villages: Array[Village] = find_nearby_villages(building.global_position)
	
	if nearby_villages.size() == 1:
		nearby_villages[0].add_building(building)
		return nearby_villages[0].id
	elif nearby_villages.size() > 1:
		#show_village_picker(nearby_villages)
		nearby_villages[0].add_building(building)
		return nearby_villages[0].id
		push_warning("Implement this!")
	else:
		push_warning("No nearby villages found.")
	return ""
