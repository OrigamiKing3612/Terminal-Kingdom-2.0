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
	
	var quest = QuestManager.get_quest("blacksmith6")
	if quest:
		quest.reached_goal()
		QuestManager.update_quest("blacksmith6", quest)

	recipe.create(recipe)
