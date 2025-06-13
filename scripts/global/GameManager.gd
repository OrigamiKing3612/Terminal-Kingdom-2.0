extends Node

@onready var inventory_box: CanvasLayer = $InventoryBox
@onready var building_box: CanvasLayer = $BuildingBox

signal show_inventory
signal hide_inventory
signal show_building
signal hide_building
signal inventory_update

signal build_next
signal build_back

var move: bool = true
var has_popup: bool = false

var mode: Mode = Mode.Normal

@export var selected_item_index: int = 0
@export var selected_gridmap_id: int = 0

@export var player: PlayerData

enum Mode{Normal, Inventory, Build}

func _ready() -> void:
	player = player.duplicate(true)
	inventory_update.emit()

func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("left_click") or Input.is_action_just_pressed("right_click")) and move == false and mode != Mode.Inventory and has_popup == false:
		SceneManager.steal_cursor()
	if Input.is_action_just_pressed("esc"):
		SceneManager.free_cursor()

	match mode:
		Mode.Normal:
			if Input.is_action_just_released("inventory"):
				if inventory_box.visible == false:
					show_inventory_box()
					inventory_update.emit()
			if player.can_build && Input.is_action_just_released("build"):
				if player.items.size() < 0:
					return
				if building_box.visible == false:
					show_buildable_items()
		Mode.Build:
			if Input.is_action_just_released("back_option"):
				build_back.emit()
			elif Input.is_action_just_released("next_option"):
				build_next.emit()
			elif Input.is_action_just_released("build"):
				hide_buildable_items()
		Mode.Inventory:
			if Input.is_action_just_released("inventory"):
				hide_inventory_box()
			

func hide_inventory_box() -> void:
	hide_inventory.emit()
	inventory_box.visible = false
	SceneManager.steal_cursor()
	mode = Mode.Normal

func show_inventory_box() -> void:
	show_inventory.emit()
	inventory_box.visible = true
	SceneManager.free_cursor()
	mode = Mode.Inventory
	
func show_buildable_items() -> void:
	show_building.emit()
	building_box.visible = true
	mode = Mode.Build

func hide_buildable_items() -> void:
	hide_building.emit()
	building_box.visible = false
	mode = Mode.Normal
