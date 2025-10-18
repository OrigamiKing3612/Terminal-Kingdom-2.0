extends Control
class_name InventoryBox

@export var toolbelt: ToolbeltNode

@onready var inventory_grid_container: GridContainer = $Inventory/GridContainer

var slots: Array[InventorySlot]

var itemInHand: InventoryItem

const INVENTORY_ITEM = preload("res://scenes/ui/inventory/inventory_item.tscn")

func _ready() -> void:
	for child in inventory_grid_container.get_children():
		if child is InventorySlot:
			slots.append(child)

	for child in toolbelt.grid_container.get_children(): 
		if child is ToolbeltInventorySlot:
			slots.append(child)

	connect_slots()
	GameManager.inventory_update.connect(_on_update)
	_on_update()
	
func connect_slots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		slot.pressed.connect(func(): _on_slot_clicked(slot))
	
func _on_update():
	#for slot in slots:
		#slot.clear()

	var player_slots = GameManager.player.inventory.slots
	for i in range(min(player_slots.size(), slots.size())):
		var inv_slot: InventoryItemSlot = player_slots[i]
		if inv_slot.is_empty():
			continue

		var slot = slots[i]
		var inv_item: InventoryItem = slot.inventory_item

		if inv_item == null:
			inv_item = INVENTORY_ITEM.instantiate()
			slot.insert(inv_item)

		inv_item.item_slot = inv_slot
		inv_item.update()

func _on_slot_clicked(slot: InventorySlot):
	if slot.is_empty():
		if not itemInHand: return
		insert_item_in_slot(slot)
		return
	
	if not itemInHand:
		take_item_from_slot(slot)
		return
	
	if slot.inventory_item.item_slot.item_name == itemInHand.item_slot.item_name:
		stack_items(slot)
		return
	
	swap_items(slot)

func take_item_from_slot(slot: InventorySlot):
	itemInHand = slot.take_item()
	add_child(itemInHand)
	update_item_in_hand()
	
func insert_item_in_slot(slot: InventorySlot):
	var item = itemInHand
	remove_child(itemInHand)
	itemInHand = null
	slot.insert(item)
	
func swap_items(slot: InventorySlot):
	var item = slot.take_item()
	insert_item_in_slot(slot)
	itemInHand = item
	add_child(itemInHand)
	update_item_in_hand()

func stack_items(slot: InventorySlot):
	var slotItem := slot.inventory_item
	var maxAmount = slotItem.item_slot.item.max_amount_per_stack
	var totalAmount = slotItem.item_slot.count + itemInHand.item_slot.count
	
	if slotItem.item_slot.count == maxAmount:
		swap_items(slot)
		return
		
	if totalAmount <= maxAmount:
		slotItem.item_slot.count = totalAmount
		remove_child(itemInHand)
		itemInHand = null
	else:
		slotItem.item_slot.count = maxAmount
		itemInHand.item_slot.count = totalAmount - maxAmount
		
	slotItem.update()
	if itemInHand: itemInHand.update()


func update_item_in_hand():
	if not itemInHand: return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size / 2
	
func _input(_event: InputEvent) -> void:
	update_item_in_hand()
