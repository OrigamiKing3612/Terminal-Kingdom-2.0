extends Node3D

func _on_remove() -> void:
	queue_free()
