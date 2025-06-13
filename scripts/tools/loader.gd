@tool
extends EditorPlugin

const editorAddon = preload("res://scenes/tools/Addons.tscn")

var dockedScene

func _enter_tree() -> void:
	dockedScene = editorAddon.instantiate()
	add_control_to_dock(DOCK_SLOT_LEFT_UR, dockedScene)

func _exit_tree() -> void:
	remove_control_from_docks(dockedScene)
	dockedScene.free()
