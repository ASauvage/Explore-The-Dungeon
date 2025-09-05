extends Control


@onready var item_slots: Array[Node] = $Inventory/ItemSlots.get_children()
@onready var money: Label = $Inventory/MoneySlot/Money
@onready var item_desc_sprite: TextureRect = $Inventory/ItemDescription/ItemPreview/ItemSprite
@onready var item_desc_name: Label = $Inventory/ItemDescription/NameTextArea/ItemName
@onready var item_desc: Label = $Inventory/ItemDescription/DescriptionTextArea/ItemDesc

@export var inventory: Inventory

@onready var selected_slot: InventorySlot = inventory.slots[0]


func _ready() -> void:
	inventory.on_money_update.connect(update_money)
	inventory.on_inventory_update.connect(update_slots)
	update_money()
	update_item_desc()
	update_slots()


func update_money() -> void:
	var num_str: String = str(abs(inventory.money))
	var result: String = ""
	var count: int = 0

	for i in range(num_str.length() - 1, -1, -1):
		result = num_str[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "," + result
	
	money.text = result


func update_item_desc() -> void:
	if selected_slot.item:
		item_desc_sprite.texture = selected_slot.item.texture
		item_desc_name.text = selected_slot.item.name
		item_desc.text = selected_slot.item.description
	else:
		item_desc_sprite.texture = null
		item_desc_name.text = ""
		item_desc.text = ""


func update_slots() -> void:
	for index in range(min(inventory.slots.size(), item_slots.size())):
		item_slots[index].update(inventory.slots[index])
