extends Control


@onready var inventory: Inventory = preload("res://ressources/player_inventory.tres")
@onready var item_slots: Array[Node] = $Inventory/ItemSlots.get_children()


func _ready() -> void:
	inventory.on_inventory_update.connect(update_slots)
	update_slots()

func update_slots() -> void:
	for index in range(min(inventory.slots.size(), item_slots.size())):
		item_slots[index].update(inventory.slots[index])
