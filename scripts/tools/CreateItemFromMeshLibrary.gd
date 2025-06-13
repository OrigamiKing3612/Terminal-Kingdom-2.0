@tool 
extends EditorScript

@export var mesh_library: MeshLibrary = preload("res://assets/tiles.tres")
@export var output_path: String = "res://assets/resources/items/tiles/"

func _run():
	if not mesh_library:
		push_error("Please assign a MeshLibrary first.")
		return

	var mesh_ids := mesh_library.get_item_list()
	for id in mesh_ids:
		var raw_name = mesh_library.get_item_name(id)
		var name = add_spaces_to_camel_case(raw_name)
		var mesh = mesh_library.get_item_mesh(id)

		var item = Item.new()
		item.name = name
		item.price = 0
		item.can_be_sold = false
		item.is_buildable = true
		item.gridmap_id = id

		if mesh is ArrayMesh:
			pass

		var save_path = output_path + name.to_lower().replace(" ", "_") + ".tres"
		ResourceSaver.save(item, save_path)
		print("Saved: ", save_path)

func add_spaces_to_camel_case(text: String) -> String:
	var result := ""
	for i in text.length():
		var char = text[i]
		if i > 0 and is_upper(char):
			result += " "
		result += char
	return result.replace(" Tile", "")

func is_upper(char: String) -> bool:
	var uppers = "QWERTYUIOPASDFGHJKLZXCVBNM"
	for upper in uppers:
		if char == upper:
			return true
	return false
