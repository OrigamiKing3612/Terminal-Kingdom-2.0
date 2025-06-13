@tool
extends Button 

@export var mesh_library: MeshLibrary = preload("res://assets/tiles.tres")
@export var output_path: String = "res://assets/resources/items/tiles/"
@export var preview_image_path: String = "res://assets/models/icons/"

func _ready() -> void:
	self.pressed.connect(_on_pressed)

func run():
	if not mesh_library:
		print("Please assign a MeshLibrary first.")
		return

	print("\nRunning!")
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
			item.texture_2d = await generate_preview(mesh, item)

		var save_path = output_path + name.to_lower().replace(" ", "_") + ".tres"
		ResourceSaver.save(item, save_path)
		
		print("Saved: ", save_path)
	print("Done! Time: ", Time.get_datetime_string_from_system())

func generate_preview(mesh: Mesh, item: Item, size: Vector2 = Vector2(128, 128)) -> Texture2D:
	print("Generating Preview for ", item.name)
	var sub_viewport := SubViewport.new()
	add_child(sub_viewport)
	
	var root := Node3D.new()
	sub_viewport.add_child(root)
	
	var mesh_instance_3d := MeshInstance3D.new()
	mesh_instance_3d.mesh = mesh
	root.add_child(mesh_instance_3d)
	
	var light := OmniLight3D.new()
	root.add_child(light)
	
	var camera := Camera3D.new()
	camera.transform.origin = Vector3(0, 0, 3)
	camera.look_at_from_position(Vector3(0, 0, 3), Vector3.ZERO, Vector3.UP)
	camera.make_current()
	root.add_child(camera)

	for i in 3:
		await get_tree().process_frame

	var img = sub_viewport.get_texture().get_image()
	var tex = ImageTexture.create_from_image(img)

	var preview_path = preview_image_path + item.name.to_lower().replace(" ", "_") + "_preview.tres"
	#img.save_png(ProjectSettings.globalize_path(preview_path))
	
	print("Saved preview: ", preview_path)
	ResourceSaver.save(tex, preview_path)

	return tex

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

func _on_pressed() -> void:
	run()
