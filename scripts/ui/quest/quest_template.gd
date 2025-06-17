extends Panel
class_name QuestTemplate

@onready var title: RichTextLabel = $QuestTitle
@onready var description: RichTextLabel = $QuestDescription

func set_title(value: String):
	self.title.text = value

func set_description(value: String): 
	self.description.text = value
