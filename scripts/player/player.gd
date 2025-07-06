extends CharacterBody2D
class_name Player

@onready var camera: Camera2D = $Camera2D
@onready var raycast: RayCast2D = $RayCast2D

func _ready() -> void:
	if GameManager.mode == GameManager.Mode.Mining:
		GameManager.mine_left_click.connect(_on_left_click)
	else:
		GameManager.left_click.connect(_on_left_click)
		GameManager.right_click.connect(_on_right_click)

func _on_left_click():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		#var path = collider.get_path()
		#var type = collider.get_class()
		#print("> Ray hit: ", path, " (", type, ")")
		if collider is TileMapLayer:
			collider.destroy_tile(raycast.get_collision_point())
		elif collider and collider.has_meta("destroyable_component"):
			var component = collider.get_meta("destroyable_component")
			component.destroy()
			
func _on_right_click():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		#var path = collider.get_path()
		#var type = collider.get_class()
		#print("> Ray hit: ", path, " (", type, ")")
		if collider is GridMap:
			var pos = raycast.get_collision_point()
			var normal = raycast.get_collision_normal()
			if GameManager.mode == GameManager.Mode.Build:
				if GameManager.selected_tile_id == -1:
					push_warning("Tried to place a tile with -1 as GameManager.selected_tile_id")
					return
				collider.place_tile(pos + normal * 0.5, GameManager.selected_tile_id)
		elif collider.has_meta("interactable_component"):
			var component = collider.get_meta("interactable_component")
			component.interact()
			
	
