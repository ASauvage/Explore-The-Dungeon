extends Control


@onready var item_slots: Array[Node] = $Inventory/ItemSlots.get_children()

@export var inventory: Inventory


func _ready() -> void:
	inventory.on_inventory_update.connect(update_slots)
	update_slots()

func update_slots() -> void:
	for index in range(min(inventory.slots.size(), item_slots.size())):
		item_slots[index].update(inventory.slots[index])
