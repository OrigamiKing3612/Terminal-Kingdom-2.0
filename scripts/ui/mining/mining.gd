extends Node3D

@onready var grid_map: GridMap = $GridMap
@onready var player: CharacterBody3D = $Player

func _ready() -> void:
	(player.camera as Camera3D).make_current()
	player.light.visible = true
