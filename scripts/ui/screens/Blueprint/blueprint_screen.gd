extends Control
class_name BlueprintScreen

signal next
signal back

enum BuildingSide{front,back,top,left,right}

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

@export var tiles: Array[TileOption] = []
@export var selected_tile_index: int = 0
@export var selected_side: BuildingSide = BuildingSide.front

func _ready() -> void:
	GameManager.mode == GameManager.Mode.InPopUp
	blueprint_hotbar.show_hot_bar()
	print("Mode Set")

func _input(event: InputEvent) -> void:
	if event.is_action_released("next_option"):
		next.emit()
	if event.is_action_released("back_option"):
		back.emit()

func _process(delta: float) -> void:
	pass

func _on_zoom_out_button_pressed() -> void:
	selected_layer.scale -= Vector2(.5,.5)


func _on_zoom_in_button_pressed() -> void:
	selected_layer.scale += Vector2(.5,.5)


func _on_close_button_pressed() -> void:
	GameManager.mode == GameManager.Mode.Normal
