extends Node
class_name Village

var id: String  = UUID.string()
@export var village_name: String = "Default Village Name"
@export var courthouse_location: Vector3i
@export var _buildings: Dictionary[String, BuildingMainTile] = {}
@export var _npcs: Dictionary[String, NPC] = {}

## Called before _ready
func init(governors_desk_position: Vector3i):
	courthouse_location = governors_desk_position

func add_npc(npc: NPC):
	_npcs[npc.data.id] = npc
	npc.add_to_group("NPC", true)
	add_child(npc)
	
func get_npc(id: String):
	return _npcs.get(id, null)

func remove_npc(id: String):
	if _npcs.has(id):
		var npc = _npcs[id]
		npc.queue_free()
		_npcs.erase(id)
		
func get_npcs() -> Array[NPC]:
	return _npcs.values()

func add_building(building: BuildingMainTile) -> void:
	_buildings[building.id] = building
	#add_child(building)

func get_building(id: String) -> void:
	return _buildings.get(id, null)

func remove_building(id: String) -> void:
	if _buildings.has(id):
		#var building = _buildings[id]
		#building.queue_free()
		_buildings.erase(id)
		
func get_buildings() -> Array[BuildingMainTile]:
	return _buildings.values()

#func get_buildings_by_type(type: Building.Type) -> Array[Building]:
	#return _buildings.filter(func(b): return b.building_type == type)
