extends Area3D

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("can_use_doors"):
		SceneManager.go_back()
