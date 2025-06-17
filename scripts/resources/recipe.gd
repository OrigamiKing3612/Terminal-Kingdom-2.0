extends Resource
class_name Recipe

@export var inputs: Array[RecipeItem]
@export var outputs: Array[RecipeItem]

func _init():
	if self.get_script() == Recipe:
		push_error("Recipe cannot be instantiated directly. Please extend it.")

func create(recipe: Recipe) -> bool:
	Utils._push_must_override_error("create")
	return false

func can_create() -> bool:
	for input in inputs:
		if not GameManager.player.has_count(input.item.name, input.count)[0]:
			return false
	return true
