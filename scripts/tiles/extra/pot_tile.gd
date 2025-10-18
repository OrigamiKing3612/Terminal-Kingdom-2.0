extends Node2D

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
	var progress = clamp(growth_timer / plant.growth_time, 0, 1)
	if progress < 0.33:
		set_stage(Plant.Stage.seed)
	elif progress < 0.66:
		set_stage(Plant.Stage.sprout)
	else:
		set_stage(Plant.Stage.mature)

func plant_seed(new_seed: Plant):
	if plant_instance:
		remove_child(plant_instance)
		plant_instance.queue_free()

	plant = new_seed.duplicate()
	if plant.scene:
		plant_instance = plant.scene.instantiate()
		add_child(plant_instance)
	else:
		push_error("No plant scene")
	growth_timer = 0.0
	_stage = Plant.Stage.seed

func harvest() -> void:
	if GameManager.player.skill.farming.stage == 3:
		var quest = QuestManager.get_quest("farm3")
		if quest.quest_status == quest.QuestStatus.started:
			quest.reached_goal()
			QuestManager.update_quest("farm3", quest)

	if plant.harvest_item:
		var count := plant.max_amount if (plant.max_amount == plant.min_amount) else randi_range(plant.min_amount, plant.max_amount)
		Utils.givePlayerCountOfItem(plant.harvest_item, count)

	plant = null
	growth_timer = 0.0
	_stage = Plant.Stage.seed
	remove_child(plant_instance)
	plant_instance.queue_free()

func set_stage(new_stage: Plant.Stage):
	_stage = new_stage
	plant_instance.stage = new_stage

func _on_interacted() -> void:
	if GameManager.player.skill.farming.stage == 2:
		var quest = QuestManager.get_quest("farm2")
		if quest.quest_status == quest.QuestStatus.started:
			quest.reached_goal()
			QuestManager.update_quest("farm2", quest)
	
	if plant != null:
		if stage == Plant.Stage.mature:
			harvest()
			return
	if GameManager.selectedItem:
		match GameManager.selectedItem.seed:
			Utils.SeedType.Beet: plant_seed(load("res://assets/resources/plants/beet_plant.tres"))
			Utils.SeedType.Cabbage: plant_seed(load("res://assets/resources/plants/cabbage_plant.tres"))
			Utils.SeedType.Carrot: plant_seed(load("res://assets/resources/plants/carrot_plant.tres"))
			Utils.SeedType.Onion: plant_seed(load("res://assets/resources/plants/onion_plant.tres"))
			Utils.SeedType.Pumpkin: plant_seed(load("res://assets/resources/plants/pumpkin_plant.tres"))
			Utils.SeedType.TreeSeed: print_debug("tree seed needs implementing")
		#plant_seed()
