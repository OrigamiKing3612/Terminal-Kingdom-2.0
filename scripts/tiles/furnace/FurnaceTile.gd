extends Node3D

@onready var fire: MeshInstance3D = $LightmapGI/Fire
@export var furnace_screen: PackedScene

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

func _ready() -> void:
	var recipes: Array[FurnaceRecipe] = []
	for resource in Utils.load_all_from_path("res://assets/resources/recipes/furnace/"):
		if resource is FurnaceRecipe:
			recipes.append(resource)
	fire.hide()

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
	state = FurnaceState.running
	await get_tree().create_timer(recipe.seconds).timeout

	recipe.create(recipe)
	state = FurnaceState.unused
