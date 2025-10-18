extends CanvasLayer

@onready var v_box_container: VBoxContainer = $VBoxContainer
var messages: Dictionary[String, Item] = {}
const ADD_ITEM_TEMPLATE = preload("res://scenes/ui/messages/AddItem.tscn")

func _ready() -> void:
	show()

func _on_show_message(item: Item, type: Utils.CollectedItemType) -> void:
	messages[item.id] = item

	var node = ADD_ITEM_TEMPLATE.instantiate()		
	v_box_container.add_child(node)
	node.init(item, type)
	node.show()

	#await get_tree().create_timer(3.0).timeout
	#if node.is_inside_tree():
		#messages.erase(item.id)
		#node.queue_free()
