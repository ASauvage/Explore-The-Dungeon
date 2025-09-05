extends Resource
class_name Inventory


@export var money: int = 0
@export var slots: Array[InventorySlot]
@export var equipement_slot: ItemEquipement
@export var weapon_slot: ItemWeapon

signal on_money_update
signal on_inventory_update


func set_money(amount: int) -> void:
	money += amount
	on_money_update.emit()


func insert_item(item: Item) -> void:
	var available_slot = slots.filter(func(slot): return slot != null and slot.item == item and slot.amount < item.stack_size)
	available_slot.append_array(slots.filter(func(slot): return slot == null))
	
	if !available_slot.is_empty():
		available_slot[0].amount += 1
		on_inventory_update.emit()
	else:
		pass # TODO


func change_weapon(item: ItemWeapon) -> ItemWeapon:
	var old_item = weapon_slot
	weapon_slot = item
	return old_item


func change_equipement(item: ItemEquipement) -> ItemEquipement:
	var old_item = equipement_slot
	equipement_slot = item
	return old_item


# old code ----------------------------------------------
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
