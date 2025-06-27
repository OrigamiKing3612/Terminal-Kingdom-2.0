extends Node
class_name HiresComponent

## npc ids
@export var workers: Array[String] = []
@export var max_workers: int = 2
## job and is full
@export var jobs: Dictionary[Utils.Job, bool]

func hire(npcID: String):
	workers.append(npcID)
	
func fire(npcID: String):
	workers.erase(npcID)

func is_hiring() -> bool:
	return workers.size() < max_workers

func get_jobs() -> Dictionary[Utils.Job, bool]:
	return jobs
