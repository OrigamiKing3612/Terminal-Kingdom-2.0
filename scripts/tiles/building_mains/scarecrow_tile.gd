extends BuildingMainTile
class_name ScarecrowTile

const SCARECROW_SCREEN = preload("res://scenes/ui/screens/Scarecrow/ScarecrowScreen.tscn")

func when_placed():
	village_id = GameManager.kingdom.add_building_to_closest_village(self)

func _on_interacted() -> void:
	var popup = SCARECROW_SCREEN.instantiate()
	SceneManager.show_popup(popup)
