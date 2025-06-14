extends Node

@export var dialogue: DialogueResource

func talk(data: NPCData) -> void:
	DialogueManager.show_dialogue_balloon(dialogue, "start", [{"data": data}])
