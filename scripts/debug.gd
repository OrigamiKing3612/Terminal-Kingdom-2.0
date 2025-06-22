extends CanvasLayer

@onready var tab_container: TabContainer = $TabContainer
@onready var items_container: VBoxContainer = $TabContainer/Items/VBoxContainer
@onready var button: Button = $TabContainer/Items/VBoxContainer/Button

const items_dir := "res://assets/resources/items/"

func _ready() -> void:
	var items = get_all_resources_from_folder(items_dir)
	for item in items:
		var new_button: Button = button.duplicate()
		new_button.text = item.name
		new_button.pressed.connect(func(): _on_item_button_pressed(item))
		items_container.add_child(new_button)
		new_button.show()

func _on_item_button_pressed(item: Item):
	Utils.givePlayerCountOfItem(item, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_all_resources_from_folder(path: String) -> Array:
	var dir = DirAccess.open(path)
	if dir == null:
		push_error("Could not open directory: %s" % path)
		return []
	
	var resources := []
	dir.list_dir_begin()

	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
		if dir.current_is_dir():
			if file_name != "." and file_name != "..":
				var subfolder = path + "/" + file_name
				resources += get_all_resources_from_folder(subfolder)
				continue
		if file_name.ends_with(".import"):
			continue

		var file_path = path + "/" + file_name
		var res = ResourceLoader.load(file_path)
		if res and res is Item:
			resources.append(res)

	dir.list_dir_end()

	return resources
