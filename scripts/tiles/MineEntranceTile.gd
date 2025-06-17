extends StaticBody3D

const MINING = preload("res://scenes/ui/mining/Mining.tscn")

func interact() -> void:
	GameManager.mode = GameManager.Mode.Mining
	SceneManager.go_to_scene(MINING)
