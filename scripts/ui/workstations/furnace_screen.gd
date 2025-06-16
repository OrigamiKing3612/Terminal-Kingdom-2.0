extends Control

@onready var recipes_container: VBoxContainer = $RecipesContainer
@onready var preview_image: TextureButton = $PreviewImage
@onready var template_button: Button = $RecipesContainer/Button

var recipes: Array[FurnaceRecipe] = []
var selected_recipe: FurnaceRecipe

func _ready() -> void:
	template_button.hide()
	
	for recipe in recipes:
		var button = template_button.duplicate() as Button
		button.text = ", ".join(recipe.outputs.map(func(r): return r.item.name))
		button.show()
		recipes_container.add_child(button)

func _process(delta: float) -> void:
	pass
