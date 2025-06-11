extends Popup

signal door_menu_choice(choice)

enum DOOR_MENU_CHOICE {GO_INSIDE}

func _ready() -> void:
	$GoInsideButton.pressed.connect(_on_go_inside_button_pressed)

func _on_go_inside_button_pressed() -> void:
	emit_signal("door_menu_choice", DOOR_MENU_CHOICE.GO_INSIDE)
	queue_free()
