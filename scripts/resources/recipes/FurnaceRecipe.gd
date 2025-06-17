extends Recipe
class_name FurnaceRecipe

@export var seconds: int = 10

func create(recipe: Recipe) -> bool:
	if not can_create():
		return false
	for input in inputs:
		for i in range(input.count):
			GameManager.player.removeItemItem(input.item)
	for output in outputs:
		GameManager.player.collectItem(output.item, output.count)
	return true
