extends Button

signal press(id: String)

@export var recipe_id: String

func _on_pressed() -> void:
	press.emit(recipe_id)
