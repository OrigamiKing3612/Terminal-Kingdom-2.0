extends Node3D

const SAW_SCREEN = preload("res://scenes/ui/screens/Saw/SawScreen.tscn")

func _on_interacted() -> void:
	var popup = SAW_SCREEN.instantiate()
	SceneManager.show_popup(popup)
