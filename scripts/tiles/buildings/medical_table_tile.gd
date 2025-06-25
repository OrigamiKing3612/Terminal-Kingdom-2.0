extends Node3D

const MEDICAL_TABLE_SCREEN = preload("res://scenes/ui/screens/MedicalTable/MedicalTableScreen.tscn")

func _on_interacted() -> void:
	var popup = MEDICAL_TABLE_SCREEN.instantiate()
	SceneManager.show_popup(popup)
