extends Control
class_name InventoryBox

@onready var inventory_slot_template: InventorySlot = $InventorySlotTemplate
@onready var grid_container: GridContainer = $GridContainer
var slots: Array[InventorySlot]

var itemInHand: InventoryItem

const INVENTORY_ITEM = preload("res://scenes/ui/inventory/inventory_item.tscn")

func _ready() -> void:
	for child in $GridContainer.get_children(): 
		if child is InventorySlot:
			slots.append(child)
	
	connect_slots()
	GameManager.inventory_update.connect(_update)
	_update()
	
func connect_slots():
	for slot in slots:
		slot.pressed.connect(func(): _on_slot_clicked(slot))
	
func _update():
	for i in slots.size():
		slots[i].clear()
	var inventory_items: Dictionary[Item, int] = {}
	for item in GameManager.player.items:
		if item in inventory_items:
			inventory_items[item] += 1
		else:
			inventory_items[item] = 1

	var inventory_item_slots: Array[InventoryItemSlot]
	for item in inventory_items.keys():
		var s := InventoryItemSlot.new()
		s.item = item
		s.count = inventory_items[item]
		inventory_item_slots.append(s)

	for i in range(min(inventory_item_slots.size(), slots.size())):
		var slot := inventory_item_slots[i]
		if not slot.item: continue
		
		var inventory_item: InventoryItem = INVENTORY_ITEM.instantiate()
		slots[i].insert(inventory_item)
		inventory_item.update(slot)

func _on_slot_clicked(slot: InventorySlot):
	if slot.is_empty() && itemInHand:
		insert_item_in_slot(slot)
		print("Inserted")
		return
	
	if not itemInHand:
		take_item_from_slot(slot)
		print("took")

func take_item_from_slot(slot: InventorySlot):
	itemInHand = slot.take_item()
	add_child(itemInHand)
	update_item_in_hand()
	
func insert_item_in_slot(slot: InventorySlot):
	var item = itemInHand
	remove_child(itemInHand)
	itemInHand = null
	
	slot.insert(item)

func update_item_in_hand():
	if not itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size / 2# - Vector2(0, -40)
	
func _input(event: InputEvent) -> void:
	update_item_in_hand()
