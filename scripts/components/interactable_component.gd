extends Node2D
class_name InteractableComponent

signal interacted

@export var node: PhysicsBody2D

func _ready():
	if node:
		node.set_meta("interactable_component", self)
	else:
		push_warning("No PhysicsBody2D assigned to InteractableComponent")

func interact():
	interacted.emit()
