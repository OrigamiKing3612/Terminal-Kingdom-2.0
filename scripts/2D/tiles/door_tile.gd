extends Node2D
class_name DoorTile

@export var mode: DoorMode = DoorMode.go_inside
@export var inside_scene: PackedScene

func _on_area_2d_body_entered(body: Node2D) -> void:
	if mode == DoorMode.go_inside:
		if body.is_in_group("Player"):
			SceneManager.go_to_scene(inside_scene)
			SceneManager.overlay_scene.get_node("Player").get_node("Camera2D").enabled = true
			get_tree().get_first_node_in_group("Player").get_node("Camera2D").enabled = false
	elif mode == DoorMode.go_outside:
		SceneManager.go_back()
		get_tree().get_first_node_in_group("Player").global_position = GameManager.player.position
		get_tree().get_first_node_in_group("Player").get_node("Camera2D").enabled = true

enum DoorMode{go_inside,go_outside}
