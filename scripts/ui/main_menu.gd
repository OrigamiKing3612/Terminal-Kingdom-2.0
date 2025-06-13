extends VBoxContainer

const GAME = preload("res://scenes/Game.tscn")

func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_packed(GAME)


func _on_load_game_button_pressed() -> void:
	pass # Replace with function body.


func _on_help_button_pressed() -> void:
	pass # Replace with function body.


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
