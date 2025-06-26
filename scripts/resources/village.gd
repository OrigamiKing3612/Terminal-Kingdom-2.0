extends Resource
class_name Village

var id: String  = UUID.string()
@export var name: String = "Default Village Name"
@export var npcs: Array[String]

func add_npc(npc: NPC):
	npcs.append(npc.data.id)
