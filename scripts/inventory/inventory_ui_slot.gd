extends Panel


@onready var item_sprite: TextureRect = $ItemSprite
@onready var item_count: Label = $ItemCount


func update(slot: InventorySlot) -> void:
	if !slot.item:
		item_sprite.visible = false
		item_count.visible = false
	else:
		item_sprite.visible = true
		item_count.visible = slot.amount > 1
		item_sprite.texture = slot.item.texture
		item_count.text = str(slot.amount)
