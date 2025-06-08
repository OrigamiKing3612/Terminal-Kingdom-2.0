extends Area3D

@export var target_scene: PackedScene

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("can_use_doors"):
		SceneManager.go_to_scene(target_scene)
