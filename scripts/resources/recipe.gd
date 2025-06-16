extends Resource
class_name Recipe

@export var inputs: Array[RecipeItem]
@export var outputs: Array[RecipeItem]

func _init():
	if self.get_script() == Recipe:
		push_error("Recipe cannot be instantiated directly. Please extend it.")

func create(recipe: Recipe) -> void:
	Utils._push_must_override_error("create")
