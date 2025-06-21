extends Node

@export var dialogue: DialogueResource

func _ready() -> void:
	pass

func talk(_data: NPCData) -> void:
	DialogueManager.show_dialogue_balloon(dialogue, "start")
