extends Node3D

const WORKBENCH_SCREEN = preload("res://scenes/ui/screens/Workbench/WorkbenchScreen.tscn")

func _on_interacted() -> void:
	var popup = WORKBENCH_SCREEN.instantiate()
	SceneManager.show_popup(popup)
