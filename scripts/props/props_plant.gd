class_name PropPot extends Node2D


func _ready() -> void:
	pass


func _on_hit_box_damaged(damage: int) -> void:
	queue_free()
