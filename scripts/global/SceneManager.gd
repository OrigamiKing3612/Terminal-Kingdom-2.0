extends Node

var previous_scene: String
var current_popup: Control = null

func go_to_scene(new_scene: PackedScene):
	previous_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_packed(new_scene)

func free_cursor(): 
	GameManager.move = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func steal_cursor():
	GameManager.move = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func show_popup(popup: Control):
	if current_popup:
		current_popup.queue_free()
	current_popup = popup
	get_tree().current_scene.add_child(popup)

func go_back():
	if previous_scene:
		get_tree().change_scene_to_file(previous_scene)
	else:
		print("No previous scene to go back to.")
