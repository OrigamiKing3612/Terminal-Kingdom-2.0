extends Node3D

const TARGET_SCREEN = preload("res://scenes/ui/screens/Target/TargetScreen.tscn")

func _on_interacted() -> void:
	var popup = TARGET_SCREEN.instantiate()
	SceneManager.show_popup(popup)
