extends Control
class_name BlueprintScreen

signal next
signal back

enum BuildingSide{front,back,top,left,right}
@onready var layer_top: TileMapLayer = $CanvasLayer/BlueprintContainer/Control/Top
@onready var layer_front: TileMapLayer = $CanvasLayer/BlueprintContainer/Control/Front
@onready var layer_back: TileMapLayer = $CanvasLayer/BlueprintContainer/Control/Back
@onready var layer_left: TileMapLayer = $CanvasLayer/BlueprintContainer/Control/Left
@onready var layer_right: TileMapLayer = $CanvasLayer/BlueprintContainer/Control/Right

@onready var color_rect: ColorRect = $ColorRect
@onready var hot_bar: HotBar = $HotBar
@onready var zoom_out_button: Button = $VBoxContainer/ZoomOutButton
@onready var zoom_in_button: Button = $VBoxContainer/ZoomInButton
@onready var blueprint_hotbar: BlueprintHotBar = $BlueprintHotbar
@onready var selected_layer: TileMapLayer = $CanvasLayer/BlueprintContainer/Control/Front:
	set(new_value):
		selected_layer = new_value
		selected_side_label.text = selected_layer.name
@onready var selected_side_label: RichTextLabel = $SelectedSideLabel

@export var blueprint_item_template: BlueprintItem
@export var tiles: Array[TileOption] = []
@export var selected_tile_index: int = 0
@export var selected_side: BuildingSide = BuildingSide.front

func _ready() -> void:
	GameManager.mode == GameManager.Mode.InPopUp
	blueprint_hotbar.show_hot_bar()

func _input(event: InputEvent) -> void:
	if event.is_action_released("next_option"):
		next.emit()
	if event.is_action_released("back_option"):
		back.emit()

func _on_zoom_out_button_pressed() -> void:
	selected_layer.scale -= Vector2(.5,.5)


func _on_zoom_in_button_pressed() -> void:
	selected_layer.scale += Vector2(.5,.5)


func _on_close_button_pressed() -> void:
	GameManager.mode == GameManager.Mode.Normal


func _on_done_button_pressed() -> void:
	var blueprint_data := BlueprintData.new()
	blueprint_data.data[Utils.BuildingSide.Top] = blueprint_data.extract_data_from_layer(layer_top)
	blueprint_data.data[Utils.BuildingSide.Right] = blueprint_data.extract_data_from_layer(layer_right)
	blueprint_data.data[Utils.BuildingSide.Left] = blueprint_data.extract_data_from_layer(layer_left)
	blueprint_data.data[Utils.BuildingSide.Front] = blueprint_data.extract_data_from_layer(layer_front)
	blueprint_data.data[Utils.BuildingSide.Back] = blueprint_data.extract_data_from_layer(layer_back)
	blueprint_data.name = "Blueprint Test".strip_edges()
	
	var blueprint_item: BlueprintItem = blueprint_item_template.copy()
	blueprint_item.name = blueprint_data.name
	if not blueprint_item.name.to_lower().contains("blueprint"):
		blueprint_item.name = blueprint_item.name + " Blueprint"
	blueprint_item.blueprint_data = blueprint_data
	
	GameManager.player.collectItem(blueprint_item)
