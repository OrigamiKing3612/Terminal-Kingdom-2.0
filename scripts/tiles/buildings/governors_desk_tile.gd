extends Node3D

const GOVERNORS_DESK_SCREEN = preload("res://scenes/ui/screens/GovernorsDesk/GovernorsDeskScreen.tscn")

func _on_interacted() -> void:
	var popup = GOVERNORS_DESK_SCREEN.instantiate()
	SceneManager.show_popup(popup)
	popup.init()
	popup.position_to_spawn_npcs = position + Vector3(0, 2, 0)
