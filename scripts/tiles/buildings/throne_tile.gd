extends Node3D

const THRONE_SCREEN = preload("res://scenes/ui/screens/Throne/ThroneScreen.tscn")

func _on_interacted() -> void:
	var popup = THRONE_SCREEN.instantiate()
	SceneManager.show_popup(popup)
