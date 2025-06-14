extends Node

@export var dialogue: DialogueResource

func talk(data: NPCData):
	DialogueManager.show_dialogue_balloon(dialogue, "first_dialogue")
	SceneManager.free_cursor()
