@tool
extends Button

@export var preview_image_path: String = "res://assets/models/icons/"
@export var scenes: Dictionary[PackedScene, String] = {}

func _ready() -> void:
	pass

func _on_pressed() -> void:
	print("Started")
	for scene in scenes.keys():
		var scene_name := scenes[scene]
		var instance = scene.instantiate()
		for child in instance.get_children():
			if child is MeshInstance3D:
				await generate_preview(child.mesh, scene_name)
				break

func generate_preview(mesh: Mesh, item_name: String, image_size: Vector2 = Vector2(128, 128)) -> Texture2D:
	print("Generating Preview for ", item_name)
	
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

	var image_name = item_name.to_lower().replace(" ", "_") + "_preview.tres"
	var preview_path = preview_image_path + image_name
	#img.save_png(ProjectSettings.globalize_path(preview_path))
	
	print("Saved preview: ", image_name)
	ResourceSaver.save(texure, preview_path)
	
	sub_viewport.queue_free()

	return texure
