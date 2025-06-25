extends Node3D

const SCARECROW_SCREEN = preload("res://scenes/ui/screens/Scarecrow/ScarecrowScreen.tscn")

func _on_interacted() -> void:
	var popup = SCARECROW_SCREEN.instantiate()
	SceneManager.show_popup(popup)
