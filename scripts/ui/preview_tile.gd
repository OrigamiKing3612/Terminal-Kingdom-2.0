extends Node2D

@export var tileset: TileSet
@onready var sprite: Sprite2D = $Sprite2D

var player: Player
var last_selected_id = -1

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	#sprite.texture = TileDB.get_tile(GameManager.selected_tile_id).drop_item.texture_2d

func _process(delta):
	if GameManager.mode != GameManager.Mode.Build:
		sprite.visible = false
		return
	sprite.visible = true
#
	var selected_id = GameManager.selected_tile_id
	if selected_id != last_selected_id:
		pass
		#var mesh = meshlib.get_item_mesh(selected_id)
		#if mesh:
			#mesh_instance_3d.mesh = mesh
			#last_selected_id = selected_id
#
	var is_colliding = player.raycast.is_colliding()
	var hit = player.raycast.target_position + player.position
	
	update_ghost_position(hit)

func update_ghost_position(pos: Vector2) -> void:
	#var local = gridmap.to_local(world_point)
	#var grid_pos = gridmap.local_to_map(local)
	#grid_pos.y = int(round(local.y / gridmap.cell_size.y))
	global_position = pos
	#rotation_degrees = GameManager.rotation
