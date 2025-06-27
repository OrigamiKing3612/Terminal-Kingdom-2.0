extends BuildingMainTile
class_name SawTile

const SAW_SCREEN = preload("res://scenes/ui/screens/Saw/SawScreen.tscn")

func when_placed():
	village_id = GameManager.kingdom.add_building_to_closest_village(self)

func _on_interacted() -> void:
	var popup = SAW_SCREEN.instantiate()
	SceneManager.show_popup(popup)
