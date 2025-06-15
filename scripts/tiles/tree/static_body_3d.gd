extends StaticBody3D

signal remove

@export var drop: Item = preload("res://assets/resources/items/tiles/lumber_item_one.tres")

func destroy() -> void:
	print("Tree")
	GameManager.player.collectItem(drop, GameManager.random.randi_range(1, 3))
	remove.emit()
