extends CanvasLayer

@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var text_template: RichTextLabel = $VBoxContainer/Text
var messages: Array[String] = []

func _ready() -> void:
	text_template.visible = false

func _on_show_message(text: String) -> void:
	messages.append(text)
	for message in messages:
		var message_node := text_template.duplicate() as RichTextLabel
		message_node.visible = true
		message_node.text = message
		
		v_box_container.add_child(message_node)
		
		await get_tree().create_timer(3.0).timeout
		if message_node.is_inside_tree():
			message_node.queue_free()
