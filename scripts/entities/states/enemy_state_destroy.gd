class_name EnemyStateDestroy extends EnemyState


@export var anim_name: String = "death"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0

var _direction: Vector2
var _damage_position: Vector2


func init() -> void:
	enemy.on_destroy.connect(_on_enemy_destroy)


func enter() -> void:
	enemy.invulnerable = true
	
	_direction = enemy.global_position.direction_to(_damage_position)
	
	enemy.velocity = _direction * -knockback_speed
	enemy.set_direction(_direction)
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)


func process(_delta: float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null


func physics(_delta: float) -> EnemyState:
	return null


func exit() -> void:
	pass


func _on_enemy_destroy(hurtbox: HurtBox) -> void:
	_damage_position = hurtbox.global_position
	state_machine.change_state(self)


func _on_animation_finished(_anim_name: StringName) -> void:
	enemy.queue_free()
