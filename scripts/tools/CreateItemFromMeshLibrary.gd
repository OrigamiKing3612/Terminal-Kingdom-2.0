@tool 
extends EditorScript

@export var mesh_library: MeshLibrary
@export var output_path: String = "res://assets/resources/items/"

func _run():
	if not mesh_library:
		push_error("Please assign a MeshLibrary first.")
		return

	var mesh_ids := mesh_library.get_item_list()
	for id in mesh_ids:
		var name = mesh_library.get_item_name(id)
		var mesh = mesh_library.get_item_mesh(id)

		var item = Item.new()
		item.name = name
		item.price = 0
		item.can_be_sold = false
		item.is_buildable = true
		item.gridmap_id = id

		# Optional: auto-generate a texture preview
		if mesh is ArrayMesh:
			# You could bake an icon here, or set a default one:
			# item.texture_2d = preload("res://assets/default.png")
			pass

		var save_path = output_path + name + ".tres"
		#ResourceSaver.save(save_path, item)
		print("Saved: ", save_path)

	print("Done creating items.")
