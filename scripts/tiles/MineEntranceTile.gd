extends StaticBody3D

const MINING = preload("res://scenes/ui/mining/Mining.tscn")

func _ready() -> void:
	print("Ready")
	GameManager.mine_left_click.connect(_on_left_click)
	GameManager.mine_right_click.connect(_on_right_click)
	GameManager.stop_mining.connect(_on_stop_mining)

func interact() -> void:
	GameManager.mode = GameManager.Mode.Mining
	SceneManager.go_to_scene(MINING)

func _on_left_click(): 
	print("left")
	
func _on_right_click():
	print("right")
	
func _on_stop_mining():
	SceneManager.go_back()
	GameManager.mode = GameManager.Mode.Mining
