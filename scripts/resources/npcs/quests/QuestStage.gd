class_name QuestStage extends Node

@export var id: String

func _ready() -> void:
	if id == "":
		push_error("id can not be empty")
