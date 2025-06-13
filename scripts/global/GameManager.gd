extends Node

@onready var inventory_box: CanvasLayer = $InventoryBox
signal show_inventory
signal hide_inventory

var move: bool = true
var has_popup: bool = false
@export var player: PlayerData

func _ready() -> void:
	player = player.duplicate()

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
			

func hide_inventory_box() -> void:
	hide_inventory.emit()
	inventory_box.visible = false
	SceneManager.steal_cursor()

func show_inventory_box() -> void:
	show_inventory.emit()
	inventory_box.visible = true
	SceneManager.free_cursor()
	
