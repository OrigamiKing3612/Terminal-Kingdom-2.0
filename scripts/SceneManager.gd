extends Node

var previous_scene: String

func go_to_scene(new_scene: PackedScene):
	previous_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_packed(new_scene)

func go_back():
	if previous_scene:
		get_tree().change_scene_to_file(previous_scene)
	else:
		print("No previous scene to go back to.")
