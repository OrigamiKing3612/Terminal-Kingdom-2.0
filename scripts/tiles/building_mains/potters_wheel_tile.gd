extends Node3D

const POTTERS_WHEEL_SCREEN = preload("res://scenes/ui/screens/PottersWheel/PottersWheelScreen.tscn")

func _on_interacted() -> void:
	var popup = POTTERS_WHEEL_SCREEN.instantiate()
	SceneManager.show_popup(popup)
