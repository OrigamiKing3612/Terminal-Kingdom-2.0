extends Node2D

@export var anvil_screen: PackedScene

@export var recipes: Array[AnvilRecipe]

func _ready() -> void:
	if GameManager.player.skill.blacksmithing.stage == 6:
		recipes = [load("res://assets/resources/recipes/anvil/pickaxe.tres") as AnvilRecipe]
		return
	elif GameManager.player.skill.blacksmithing.stage == 7:
		recipes = [load("res://assets/resources/recipes/anvil/sword.tres") as AnvilRecipe]
		return
	
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

	recipe.create()
