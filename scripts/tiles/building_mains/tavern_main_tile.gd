extends BuildingMainTile
class_name TavernMainTile

const TAVERN_SCREEN = preload("res://scenes/ui/screens/Tavern/TavernScreen.tscn")

func when_placed():
	village_id = GameManager.kingdom.add_building_to_closest_village(self)

func _on_interacted() -> void:
	var popup = TAVERN_SCREEN.instantiate()
	SceneManager.show_popup(popup)
