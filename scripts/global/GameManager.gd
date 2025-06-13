extends Node

@onready var inventory_box: CanvasLayer = $InventoryBox
@onready var building_box: CanvasLayer = $BuildingBox

signal show_inventory
signal hide_inventory
signal show_building
signal hide_building

var move: bool = true
var has_popup: bool = false
var build_mode: bool:
	get:
		return building_box.visible

@export var selected_item_index: int = 0
@export var selected_gridmap_id: int = 0

@export var player: PlayerData

func _ready() -> void:
	player = player.duplicate(true)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("inventory"):
		if inventory_box.visible == false:
			show_inventory_box()
		else:
			hide_inventory_box()
	if (Input.is_action_just_pressed("left_click") or Input.is_action_just_pressed("right_click")) and move == false and inventory_box.visible == false and has_popup == false:
		SceneManager.steal_cursor()
	if Input.is_action_just_pressed("esc"):
		SceneManager.free_cursor()
	if player.can_build && Input.is_action_just_pressed("build"):
		if player.items.size() < 0:
			return
		if building_box.visible == false:
			show_buildable_items()
		else:
			hide_buildable_items()
			
		


func hide_inventory_box() -> void:
	hide_inventory.emit()
	inventory_box.visible = false
	SceneManager.steal_cursor()

func show_inventory_box() -> void:
	show_inventory.emit()
	inventory_box.visible = true
	SceneManager.free_cursor()
	
func show_buildable_items() -> void:
	show_building.emit()
	building_box.visible = true

func hide_buildable_items() -> void:
	hide_building.emit()
	building_box.visible = false
