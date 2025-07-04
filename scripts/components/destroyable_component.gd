extends Node2D
class_name DestroyableComponent

@export var static_body: StaticBody2D
@export var tile_id: int = -1

func _ready():
	if static_body:
		static_body.set_meta("destroyable_component", self)
	else:
		push_warning("No StaticBody2D assigned to DestroyableComponent")

	if tile_id == -1:
		push_error("Missing a valid tile_id")

func destroy():
	if tile_id == -1:
		push_warning("DestroyableComponent: drop_data has invalid tile_id")
		return
#
	var can_break := Utils.break_tile(tile_id)
	if can_break:
		get_parent().queue_free()
