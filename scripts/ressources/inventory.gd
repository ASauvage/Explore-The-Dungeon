extends Resource
class_name Inventory


@export var money: int = 0
@export var slots: Array[InventorySlot]

signal on_money_update
signal on_inventory_update


func set_money(amount: int) -> void:
	money += amount
	on_money_update.emit()


func insert(item: Item) -> bool:
	var item_slots = slots.filter(func(slot): return slot.item == item and slot.amount < item.stack_size)
	
	if !item_slots.is_empty():
		item_slots[0].amount += 1
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
		else:
			return false
			
	on_inventory_update.emit()
	return true
