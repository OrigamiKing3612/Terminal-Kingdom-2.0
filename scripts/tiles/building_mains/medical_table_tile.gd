extends BuildingMainTile
class_name MedicalTableTile

const MEDICAL_TABLE_SCREEN = preload("res://scenes/ui/screens/MedicalTable/MedicalTableScreen.tscn")

func when_placed():
	village_id = GameManager.kingdom.add_building_to_closest_village(self)

func _on_interacted() -> void:
	var popup = MEDICAL_TABLE_SCREEN.instantiate()
	SceneManager.show_popup(popup)
