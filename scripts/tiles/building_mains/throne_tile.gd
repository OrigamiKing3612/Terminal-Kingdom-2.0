extends BuildingMainTile
class_name ThroneTile

const THRONE_SCREEN = preload("res://scenes/ui/screens/Throne/ThroneScreen.tscn")

func when_placed():
	village_id = GameManager.kingdom.add_building_to_closest_village(self)

func _on_interacted() -> void:
	var popup = THRONE_SCREEN.instantiate()
	SceneManager.show_popup(popup)
