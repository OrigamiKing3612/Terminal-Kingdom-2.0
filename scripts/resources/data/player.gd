class_name PlayerData extends Resource

@export var name: String = "DEFAULT_NAME"
@export var can_build: bool = true
@export var position: Vector3 = Vector3.ZERO
@export var items: Array[Item] = []

@export var skill: Skill
