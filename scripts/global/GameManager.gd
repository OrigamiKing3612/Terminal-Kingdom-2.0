extends Node

@onready var inventory_box: CanvasLayer = $InventoryBox

var move: bool = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("inventory"):
		if inventory_box.visible:
			inventory_box.visible = false
			SceneManager.steal_cursor()
		else:
			inventory_box.visible = true
			SceneManager.free_cursor()
			
