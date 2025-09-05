extends Panel


@onready var item_sprite: TextureRect = $ItemSprite
@onready var item_count: Label = $ItemCount

signal slot_clicked(index: int, button: int)


func update(slot: InventorySlot) -> void:
	if !slot.item:
		item_sprite.visible = false
		item_count.visible = false
	else:
		item_sprite.visible = true
		item_count.visible = slot.amount > 1
		item_sprite.texture = slot.item.texture
		item_count.text = str(slot.amount)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and (event.button_index == MOUSE_BUTTON_LEFT) and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
