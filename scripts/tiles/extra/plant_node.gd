extends Node2D
class_name PlantNode

@export var stage: Plant.Stage = Plant.Stage.seed:
	set(newValue):
		stage = newValue
		plant.hide()
		match newValue:
			Plant.Stage.seed: plant.play("seed")
			Plant.Stage.sprout: plant.play("sprout")
			Plant.Stage.mature: plant.play("mature")

@export var plant: AnimatedSprite2D
