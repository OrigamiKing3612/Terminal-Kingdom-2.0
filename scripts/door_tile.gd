extends Area3D

@export var target_scene: PackedScene

const OPEN_DOOR_MENU = preload("res://scenes/ui/open_door_menu.tscn")
@onready var popup = OPEN_DOOR_MENU.instantiate()

func _on_body_entered(body: Node) -> void:
	#if body.is_in_group("can_use_doors"):
		#SceneManager.free_cursor()
		#popup.connect("door_menu_choice", _on_door_menu_choice)
		#get_tree().current_scene.add_child(popup)
		#popup.popup_centered()
	pass

func _on_door_menu_choice(choice) -> void:
	if choice == popup.DOOR_MENU_CHOICE.GO_INSIDE:
		SceneManager.go_to_scene(target_scene)
		SceneManager.steal_cursor()
