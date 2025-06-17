extends Node3D

@export var anvil_screen: PackedScene

@export var recipes: Array[AnvilRecipe]

func _ready() -> void:
	var _recipes: Array[AnvilRecipe] = []
	for resource in Utils.load_all_from_path("res://assets/resources/recipes/anvil"):
		if resource is AnvilRecipe:
			recipes.append(resource)

func _on_interacted() -> void:
	var popup = anvil_screen.instantiate()
	popup.set_recipes(recipes)
	popup.start_creating.connect(_on_start_creating)
	SceneManager.show_popup(popup)

func _on_start_creating(recipe: Recipe) -> void:
	if not recipe is AnvilRecipe:
		return
	
	if GameManager.player.skill.blacksmithing.stage == 6:
		var quest = QuestManager.get_quest("blacksmith6")
		if quest and quest.quest_status == quest.QuestStatus.started:
			quest.reached_goal()
			QuestManager.update_quest("blacksmith6", quest)
	elif GameManager.player.skill.blacksmithing.stage == 7:
		var quest = QuestManager.get_quest("blacksmith7")
		if quest and quest.quest_status == quest.QuestStatus.started:
			quest.step_one_done()
			QuestManager.update_quest("blacksmith7", quest)
		

	recipe.create(recipe)
