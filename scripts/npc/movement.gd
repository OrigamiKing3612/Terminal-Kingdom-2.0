extends Node

var character: CharacterBody3D
@export var character_body: NodePath

func _ready() -> void:
	character = get_node(character_body)


func _process(delta: float) -> void:
	pass
