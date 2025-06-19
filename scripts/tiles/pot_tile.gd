extends Node3D

@export var plant: Plant

var growth_timer := 0.0
var stage: Plant.Stage:
	get: return _stage
var _stage := Plant.Stage.seed
var plant_instance: PlantNode

func _process(delta):
	if plant == null:
		return
	growth_timer += delta
	var progress = growth_timer / plant.growth_time
	if progress < 0.33:
		set_stage(Plant.Stage.seed)
	elif progress < 0.66:
		set_stage(Plant.Stage.sprout)
	else:
		set_stage(Plant.Stage.mature)

func plant_seed(seed: Plant):
	if plant != null:
		if stage == Plant.Stage.mature:
			harvest()
	else:
		plant = seed.duplicate()
		if plant.scene:
			plant_instance = plant.scene.instantiate()
			add_child(plant_instance)
		else:
			push_error("No plant scene")
		growth_timer = 0.0

func harvest() -> void:
	print("harvest")
	if plant.harvest_item:
		var count := plant.max if (plant.max == plant.min) else randi_range(plant.min, plant.max)
		Utils.givePlayerCountOfItem(plant.harvest_item, count)
	plant = null
	growth_timer = 0.0
	set_stage(Plant.Stage.seed)

func set_stage(new_stage: Plant.Stage):
	_stage = new_stage
	plant_instance.stage = new_stage

func _on_interacted() -> void:
	#plant_seed(load("res://assets/resources/plants/cabbage_plant.tres"))
	pass
