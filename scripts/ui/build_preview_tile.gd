extends Node3D

@export var raycast: RayCast3D
@export var gridmap: GridMap
@export var meshlib: MeshLibrary
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

var last_selected_id = -1
var ghost_material: StandardMaterial3D

func _ready():
	ghost_material = StandardMaterial3D.new()
	ghost_material.albedo_color.a = 0.3
	ghost_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	ghost_material.flags_transparent = true
	ghost_material.flags_unshaded = true
	mesh_instance_3d.material_override = ghost_material

func _process(delta):
	if GameManager.mode != GameManager.Mode.Build:
		mesh_instance_3d.visible = false
		return
	mesh_instance_3d.visible = true

	var selected_id = GameManager.selected_gridmap_id
	if selected_id != last_selected_id:
		var mesh = meshlib.get_item_mesh(selected_id)
		if mesh:
			mesh_instance_3d.mesh = mesh
			last_selected_id = selected_id

	var hit = raycast.get_collision_point()
	update_ghost_position(hit)

func update_ghost_position(world_point: Vector3):
	var local = gridmap.to_local(world_point)
	var grid_pos = gridmap.local_to_map(local)
	grid_pos.y = int(round(local.y / gridmap.cell_size.y))
	global_position = gridmap.to_global(gridmap.map_to_local(grid_pos))
