extends Node

#var world_scene: Node = null
var overlay_scene: Node = null

var current_popup: Control = null

#func _ready():
	#world_scene = 

func go_to_scene(new_scene: PackedScene):
	#if world_scene and world_scene.visible:
	get_tree().root.get_node("Game").hide()

	if overlay_scene:
		overlay_scene.queue_free()

	overlay_scene = new_scene.instantiate()
	
	if overlay_scene is Node3D:
		overlay_scene.transform.origin = Vector3(0, -80, 0)
	
	get_tree().root.add_child(overlay_scene)

func go_back():
	if overlay_scene:
		overlay_scene.queue_free()
		overlay_scene = null

	#if world_scene:
	get_tree().root.get_node("Game").show()
	#else:
		#print("No world scene to show.")

func free_cursor(): 
	GameManager.move = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func steal_cursor():
	GameManager.move = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func show_popup(popup: Control):
	GameManager.mode = GameManager.Mode.InPopUp
	if current_popup:
		current_popup.queue_free()
	current_popup = popup
	get_tree().current_scene.add_child(popup)
	free_cursor()
	
func hide_popup():
	if current_popup:
		current_popup.queue_free()
	GameManager.mode = GameManager.Mode.Normal
	steal_cursor()
