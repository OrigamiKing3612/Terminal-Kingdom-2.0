extends Control

@onready var recipes_container: VBoxContainer = $RecipesContainer
@onready var preview_image: TextureButton = $PreviewImage
@onready var template_button: Button = $RecipesContainer/Button
@onready var text_template: RichTextLabel = $InputOutputTextTemplate
@onready var inputs_container: VBoxContainer = $InputsContainer
@onready var outputs_container: VBoxContainer = $OutputsContainer
@onready var create_button: Button = $CreateButton
@onready var inputs_label: RichTextLabel = $InputsContainer/InputsLabel
@onready var outputs_label: RichTextLabel = $OutputsContainer/OutputsLabel

signal start_creating(Recipe)

var recipes: Dictionary[String, FurnaceRecipe] = {}
var selected_recipe: FurnaceRecipe
var seleceted_id: String

func _ready() -> void:
	template_button.hide()
	create_button.hide()
	
	for recipe_id in recipes.keys():
		var button = template_button.duplicate() as Button
		button.text = ", ".join(recipes[recipe_id].outputs.map(func(r): return r.item.name))
		button.recipe_id = recipe_id
		button.show()
		recipes_container.add_child(button)

func set_recipes(rs: Array[FurnaceRecipe]):
	for r in rs:
		recipes[UUID.string()] = r

func _on_button_press(id: String) -> void:
	create_button.hide()
	selected_recipe = recipes[id]
	seleceted_id = id
	for c in inputs_container.get_children():
		if c != inputs_label:
			c.queue_free()
	for c in outputs_container.get_children():
		if c != outputs_label:
			c.queue_free()
	preview_image.texture_normal = selected_recipe.outputs[0].item.texture_2d
	for input in selected_recipe.inputs:
		var input_button = text_template.duplicate()
		input_button.text = "%s x%d" % [input.item.name, input.count]
		inputs_container.add_child(input_button)
		input_button.show()
		
	for output in selected_recipe.outputs:
		var output_button = text_template.duplicate()
		output_button.text = "%s x%d" % [output.item.name, output.count]
		outputs_container.add_child(output_button)
		output_button.show()

	if selected_recipe.can_create():
		create_button.show()

func _on_create_button_pressed() -> void:
	create_button.disabled = true
	start_creating.emit(selected_recipe)
	queue_free()
