class_name PropPot extends Node2D


func _ready() -> void:
	pass


func _on_hit_box_damaged(hurtbox: HurtBox) -> void:
	queue_free()
