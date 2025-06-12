extends Control

@onready var panel: Panel = $Panel
@onready var v_box_container: VBoxContainer = $Panel/VBoxContainer
@onready var label: Label = $Panel/VBoxContainer/Label
@onready var close_button: Button = $Panel/VBoxContainer/CloseButton
const BUTTON_THEME = preload("res://assets/resources/ui/themes/button/button_theme.tres")

func show_dialog(text: String):
	label.text = text
	close_button.pressed.connect(close)
	
func add_button(text: String, action: Callable):
	var button := Button.new()

	button.text = text
	button.theme = BUTTON_THEME
	button.pressed.connect(func():
		close()
		action.call()
	)
	v_box_container.add_child(button)
	
func close():
	self.queue_free()
	SceneManager.steal_cursor()
