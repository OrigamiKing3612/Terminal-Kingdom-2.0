extends Node3D

const MINERS_CRATE_SCREEN = preload("res://scenes/ui/screens/MinersCrate/MinersCrateScreen.tscn")

func _on_interacted() -> void:
	var popup = MINERS_CRATE_SCREEN.instantiate()
	SceneManager.show_popup(popup)
