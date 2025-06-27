extends BuildingMainTile
class_name WorkbenchTile

const WORKBENCH_SCREEN = preload("res://scenes/ui/screens/Workbench/WorkbenchScreen.tscn")

func when_placed():
	village_id = GameManager.kingdom.add_building_to_closest_village(self)

func _on_interacted() -> void:
	var popup = WORKBENCH_SCREEN.instantiate()
	SceneManager.show_popup(popup)
