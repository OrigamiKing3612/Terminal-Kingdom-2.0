extends BuildingMainTile
class_name TargetTile

const TARGET_SCREEN = preload("res://scenes/ui/screens/Target/TargetScreen.tscn")

func when_placed():
	village_id = GameManager.kingdom.add_building_to_closest_village(self)

func _on_interacted() -> void:
	var popup = TARGET_SCREEN.instantiate()
	SceneManager.show_popup(popup)
