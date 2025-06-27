extends BuildingMainTile
class_name MinersCrateTile

const MINERS_CRATE_SCREEN = preload("res://scenes/ui/screens/MinersCrate/MinersCrateScreen.tscn")

func when_placed():
	village_id = GameManager.kingdom.add_building_to_closest_village(self)

func _on_interacted() -> void:
	var popup = MINERS_CRATE_SCREEN.instantiate()
	SceneManager.show_popup(popup)
