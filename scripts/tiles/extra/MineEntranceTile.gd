extends Node3D

const MINING = preload("res://scenes/ui/mining/Mining.tscn")

func _on_interact() -> void:
	if GameManager.player.hasTool(Utils.ToolType.Pickaxe):
		GameManager.mode = GameManager.Mode.Mining
		SceneManager.go_to_scene(MINING)
