@tool
extends Button

@export var tiles_path: String = "res://scenes/tiles/"
@export var output_path: String = "res://assets/resources/items/tiles/"
@export var drop_output_path: String = "res://assets/resources/drops/"
@export var preview_image_path: String = "res://assets/models/icons/"
@export var ids_to_ignore: Array[int] = [46,47,48]

func _ready() -> void:
	#self.pressed.connect(_on_pressed)
	pass

func run():
	push_error("This does not work!")
	return
	print("\nRunning!")
	
	#clear_directory(preview_image_path)
	
	#print("Cleared paths")
	var tiles: Array = Utils.load_all_from_path(tiles_path)
	var tile_scenes: Array[PackedScene] = []
	for tile in tiles:
		if tile is PackedScene:
			tile_scenes.append(tile)
	for tile_scene in tile_scenes:
		var raw_name = tile_scene.resource_name
		var name = add_spaces_to_camel_case(raw_name)
		#var mesh = mesh_library.get_item_mesh(id)
		var save_path = output_path + name.to_lower().replace(" ", "_") + ".tres"
		var drop_save_path = drop_output_path + name.to_lower().replace(" ", "_") + "_drop.tres"

		var item = Item.new()
		item.name = name
		item.price = 0
		item.can_be_sold = false
		item.is_buildable = true

		if FileAccess.file_exists(save_path):
			print("Skipping existing item: ", save_path)
		else:
			#if mesh is ArrayMesh:
				#item.texture_2d = await generate_preview(mesh, item)
			ResourceSaver.save(item, save_path)
			print("Saved Item: ", save_path)
			
		var drop = TileDropData.new()
		drop.id = -2
		drop.drop_item = load(save_path)
		drop.min_drop_count = 1
		drop.max_drop_count = 1
		drop.tool_required = Utils.ToolType.Pickaxe
		
		if FileAccess.file_exists(drop_save_path):
			print("Skipping existing drop item: ", drop_save_path)
		else:
			ResourceSaver.save(drop, drop_save_path)
			print("Saved Item Drop: ", save_path)
		
	print("Done! Time: ", Time.get_datetime_string_from_system())

func generate_preview(mesh: Mesh, item: Item, image_size: Vector2 = Vector2(128, 128)) -> Texture2D:
	print("Generating Preview for ", item.name)
	
	var sub_viewport := SubViewport.new()
	sub_viewport.size = image_size
	sub_viewport.transparent_bg = true
	sub_viewport.disable_3d = false
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	sub_viewport.msaa_3d = Viewport.MSAA_4X
	sub_viewport.world_3d = World3D.new() 
	
	get_tree().root.add_child(sub_viewport)
	
	var root := Node3D.new()
	sub_viewport.add_child(root)
	
	var mesh_instance_3d := MeshInstance3D.new()
	mesh_instance_3d.mesh = mesh
	root.add_child(mesh_instance_3d)
	
	var aabb := mesh.get_aabb()
	var max_dim = max(aabb.size.x, aabb.size.y, aabb.size.z)
	var distance = max_dim * 3
	var pos = Vector3(distance, 1.6, distance)
	
	var light := DirectionalLight3D.new()
	light.light_energy = 1.0
	light.rotation_degrees = Vector3(-45, -45, 0)
	light.look_at_from_position(pos, Vector3.ZERO, Vector3.UP)
	light.translate(Vector3(0, 0, 2))
	root.add_child(light)
	
	var camera := Camera3D.new()
	camera.look_at_from_position(pos, Vector3.ZERO, Vector3.UP)
	camera.fov = 20
	root.add_child(camera)
	camera.make_current()

	for i in 3:
		await get_tree().process_frame

	var img = sub_viewport.get_texture().get_image()
	var texure = ImageTexture.create_from_image(img)

	var image_name = item.name.to_lower().replace(" ", "_") + "_preview.tres"
	var preview_path = preview_image_path + image_name
	#img.save_png(ProjectSettings.globalize_path(preview_path))
	
	print("Saved preview: ", image_name)
	ResourceSaver.save(texure, preview_path)
	
	sub_viewport.queue_free()

	return texure

func add_spaces_to_camel_case(value: String) -> String:
	var result := ""
	for i in value.length():
		var ch = value[i]
		if i > 0 and is_upper(ch):
			result += " "
		result += ch
	return result.replace(" Tile", "")

func is_upper(ch: String) -> bool:
	var uppers = "QWERTYUIOPASDFGHJKLZXCVBNM"
	for upper in uppers:
		if ch == upper:
			return true
	return false

func clear_directory(path: String) -> void:
	var dir := DirAccess.open(path)
	if not dir:
		push_error("Cannot open directory: " + path)
		return

	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if file_name == "." or file_name == "..":
			file_name = dir.get_next()
			continue

		var file_path = path.path_join(file_name)
		if dir.current_is_dir():
			clear_directory(file_path)
			dir.remove(file_path)
		else:
			dir.remove(file_path)

		file_name = dir.get_next()

	dir.list_dir_end()

func _on_pressed() -> void:
	run()
