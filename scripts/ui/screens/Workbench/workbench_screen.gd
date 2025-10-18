extends Control

@export var create_blueprint_screen: PackedScene

func _on_create_blueprint_button_pressed() -> void:
	var popup = create_blueprint_screen.instantiate()
	SceneManager.show_popup(popup)
