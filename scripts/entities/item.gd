extends Node2D


@onready var sprite: Sprite2D = $Sprite

@export var item: Item


func _ready() -> void:
	sprite.texture = item.texture


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.inventory.insert(item)
		queue_free()
