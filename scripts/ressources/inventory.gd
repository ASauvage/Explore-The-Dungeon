class_name Inventory
extends Resource


@export var slots: Array[InventorySlot]

signal on_inventory_update


func insert(item: Item) -> void:
	var item_slots = slots.filter(func(slot): return slot.item == item and slot.amount < item.stack_size)
	
	if !item_slots.is_empty():
		item_slots[0].amount += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
			
	on_inventory_update.emit()
