extends BuildingMainTile
class_name FurnaceTile

@export var furnace_screen: PackedScene
@onready var fire: Node3D = $Fire

@export var recipes: Array[FurnaceRecipe]
@export var state: FurnaceState = FurnaceState.unused:
	set(value):
		state = value
		if fire:
			match state:
				FurnaceState.unused:
					fire.hide()
				FurnaceState.running:
					fire.show()

func when_placed():
	village_id = GameManager.kingdom.add_building_to_closest_village(self)

func _ready() -> void:
	fire.hide()
	if GameManager.player.skill.blacksmithing.stage == 5:
		recipes = [load("res://assets/resources/recipes/furnace/steel.tres") as FurnaceRecipe]
		return
	var _recipes: Array[FurnaceRecipe] = []
	for resource in Utils.load_all_from_path("res://assets/resources/recipes/furnace"):
		if resource is FurnaceRecipe:
			recipes.append(resource)

func _on_interacted() -> void:
	#if state == FurnaceState.unused:
		#state = FurnaceState.running
	#else:
		#state = FurnaceState.unused
	#print("furnace: " + str(state))
	var popup = furnace_screen.instantiate()
	popup.set_recipes(recipes)
	popup.start_creating.connect(_on_start_creating)
	SceneManager.show_popup(popup)

enum FurnaceState{
	unused,
	running
}
func _on_start_creating(recipe: Recipe) -> void:
	if not recipe is FurnaceRecipe:
		return
	state = FurnaceState.running
	await get_tree().create_timer(recipe.seconds).timeout

	recipe.create()
	state = FurnaceState.unused
