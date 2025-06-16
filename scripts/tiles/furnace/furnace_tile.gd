extends Node3D

signal interacted

func interact() -> void:
	interacted.emit()
