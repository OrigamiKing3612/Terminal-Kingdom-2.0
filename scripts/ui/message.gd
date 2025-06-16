extends Panel

@onready var text: RichTextLabel = $Text
@onready var color_rect: ColorRect = $ColorRect

func set_text(value: String):
	text.text = value
	color_rect.size.x = text.get_content_width()
	color_rect.size.y = text.get_content_height()
	color_rect.position.x = text.position.x
