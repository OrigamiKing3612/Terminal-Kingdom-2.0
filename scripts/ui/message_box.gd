extends CanvasLayer

@onready var text_template: RichTextLabel = $VBoxContainer/Text
@onready var v_box_container: VBoxContainer = $VBoxContainer
var messages: Dictionary[String, String] = {}

func _ready() -> void:
	text_template.hide()
	show()

func _on_show_message(text: String) -> void:
	var id := UUID.string()
	messages[id] = text

	var message_node := text_template.duplicate() as RichTextLabel
	message_node.text = text 
	v_box_container.add_child(message_node)
	message_node.show()

	await get_tree().create_timer(3.0).timeout
	if message_node.is_inside_tree():
		messages.erase(id)
		message_node.queue_free()
