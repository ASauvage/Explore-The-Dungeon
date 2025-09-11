class_name HitBox extends Area2D


signal damaged(hurtbox: HurtBox)


func take_damage(hurtbox: HurtBox) -> void:
	damaged.emit(hurtbox)
