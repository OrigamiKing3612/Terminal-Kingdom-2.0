extends Node3D
class_name PlantNode

@export var stage: Plant.Stage = Plant.Stage.seed:
	set(newValue):
		stage = newValue
		mesh_seed.hide()
		mesh_sprout.hide()
		mesh_mature.hide()
		match newValue:
			Plant.Stage.seed: mesh_seed.show()
			Plant.Stage.sprout: mesh_sprout.show()
			Plant.Stage.mature: mesh_mature.show()

@export var mesh_seed: MeshInstance3D
@export var mesh_sprout: MeshInstance3D
@export var mesh_mature: MeshInstance3D
