extends BuildingMainTile
class_name PottersWheelTile

const POTTERS_WHEEL_SCREEN = preload("res://scenes/ui/screens/PottersWheel/PottersWheelScreen.tscn")

func when_placed():
	village_id = GameManager.kingdom.add_building_to_closest_village(self)

func _on_interacted() -> void:
	var popup = POTTERS_WHEEL_SCREEN.instantiate()
	SceneManager.show_popup(popup)
