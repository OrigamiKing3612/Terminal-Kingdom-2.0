extends Node3D

@export var village_id: String

const GOVERNORS_DESK_SCREEN = preload("res://scenes/ui/screens/GovernorsDesk/GovernorsDeskScreen.tscn")

func when_placed():
	var village = Village.new()
	GameManager.kingdom.add_village(village)
	village_id = village.id

func _on_interacted() -> void:
	var popup = GOVERNORS_DESK_SCREEN.instantiate()
	SceneManager.show_popup(popup)
	popup.init(village_id)
	popup.position_to_spawn_npcs = position + Vector3(0, 2, 0)
