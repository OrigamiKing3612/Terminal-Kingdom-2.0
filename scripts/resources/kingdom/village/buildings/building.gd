extends Resource
class_name Building

var id: String = UUID.string()
@export var main_tile: Vector3i
@export var level: int = 1
@export var workers: Array[String] = []
@export var max_workers: int = 2
@export var custom_data: Dictionary = {}

func hire(npcID: String):
	workers.append(npcID)
	
func fire(npcID: String):
	workers.erase(npcID)

func is_hiring() -> bool:
	return workers.size() < max_workers
