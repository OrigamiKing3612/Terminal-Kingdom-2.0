extends GridContainer

@export var blueprint_screen: BlueprintScreen

func _on_back_button_pressed() -> void:
	blueprint_screen.selected_layer.hide()
	blueprint_screen.selected_side = BlueprintScreen.BuildingSide.back
	blueprint_screen.selected_layer = $"../CanvasLayer/BlueprintContainer/Control/Back"
	blueprint_screen.selected_layer.show()


func _on_left_button_pressed() -> void:
	blueprint_screen.selected_layer.hide()
	blueprint_screen.selected_side = BlueprintScreen.BuildingSide.left
	blueprint_screen.selected_layer = $"../CanvasLayer/BlueprintContainer/Control/Left"
	blueprint_screen.selected_layer.show()


func _on_top_button_pressed() -> void:
	blueprint_screen.selected_layer.hide()
	blueprint_screen.selected_side = BlueprintScreen.BuildingSide.top
	blueprint_screen.selected_layer = $"../CanvasLayer/BlueprintContainer/Control/Top"
	blueprint_screen.selected_layer.show()


func _on_right_button_pressed() -> void:
	blueprint_screen.selected_layer.hide()
	blueprint_screen.selected_side = BlueprintScreen.BuildingSide.right
	blueprint_screen.selected_layer = $"../CanvasLayer/BlueprintContainer/Control/Right"
	blueprint_screen.selected_layer.show()


func _on_front_button_pressed() -> void:
	blueprint_screen.selected_layer.hide()
	blueprint_screen.selected_side = BlueprintScreen.BuildingSide.front
	blueprint_screen.selected_layer = $"../CanvasLayer/BlueprintContainer/Control/Front"
	blueprint_screen.selected_layer.show()
