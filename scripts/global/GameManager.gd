extends Node

@onready var inventory_box: CanvasLayer = $InventoryBox
@onready var building_box: CanvasLayer = $BuildingBox

signal show_inventory
signal hide_inventory
signal show_building
signal hide_building
signal inventory_update

signal right_click
signal left_click

signal build_next
signal build_back

signal stop_mining
signal mine_left_click
signal mine_right_click

signal show_message(text: String)

var move: bool = true
var has_popup: bool = false

var mode: Mode = Mode.Normal

@export var selected_item_index: int = 0
@export var selected_gridmap_id: int = 0

@export var player: PlayerData
var random: RandomNumberGenerator

enum Mode{Normal, Inventory, Build, Mining, Speaking}

func _ready() -> void:
	player = player.duplicate(true)
	inventory_update.emit()
	random = RandomNumberGenerator.new()
	player.collect_item.connect(_on_collect_item)
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("left_click") or event.is_action_pressed("right_click")) and move == false and mode != Mode.Inventory and has_popup == false:
		SceneManager.steal_cursor()
	if event.is_action_pressed("esc"):
		SceneManager.free_cursor()
		
	if mode == Mode.Normal or mode == Mode.Build:
		if Input.is_action_pressed("left_click") && player.can_build:
			left_click.emit()
		if Input.is_action_pressed("right_click"):
			right_click.emit()
		
	match mode:
		Mode.Normal:
			if event.is_action_released("inventory"):
				if inventory_box.visible == false:
					show_inventory_box()
					#inventory_update.emit()
			if player.can_build && event.is_action_released("build"):
				if player.items.size() < 0:
					return
				if building_box.visible == false:
					show_buildable_items()
		Mode.Build:
			if event.is_action_released("back_option"):
				build_back.emit()
			elif event.is_action_released("next_option"):
				build_next.emit()
			elif event.is_action_released("build"):
				hide_buildable_items()
		Mode.Inventory:
			if event.is_action_released("inventory"):
				hide_inventory_box()
		Mode.Mining:
			if event.is_action_released("leave_mine"):
				stop_mining.emit()
			elif event.is_action_released("left_click"):
				mine_left_click.emit()
			elif event.is_action_released("right_click"):
				mine_right_click.emit()

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
	
func _on_collect_item(item: Item, count: int) -> void:
	var value := "+ " + item.name + " x" + str(count)
	show_message.emit(value)
	
func _on_dialogue_started(resource: DialogueResource):
	mode = Mode.Speaking
	
func _on_dialogue_ended(resource: DialogueResource):
	mode = Mode.Normal
