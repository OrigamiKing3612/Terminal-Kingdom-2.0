extends Node3D
class_name InteractableComponent

signal interacted

@export var static_body: StaticBody3D

func _ready():
	if static_body:
		static_body.set_meta("interactable_component", self)
	else:
		push_warning("No StaticBody3D assigned to InteractableComponent")

func interact():
	interacted.emit()
