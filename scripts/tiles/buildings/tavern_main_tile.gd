extends Node3D

const TAVERN_SCREEN = preload("res://scenes/ui/screens/Tavern/TavernScreen.tscn")

func _on_interacted() -> void:
	var popup = TAVERN_SCREEN.instantiate()
	SceneManager.show_popup(popup)
