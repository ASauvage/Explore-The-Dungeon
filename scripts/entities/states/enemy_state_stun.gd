class_name EnemyStateStun extends EnemyState


@export var anim_name: String = "hit"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0
@export_category("AI")
@export var next_state: EnemyState

var _direction: Vector2
var _animation_finished: bool = false


func init() -> void:
	enemy.on_damage.connect(_on_enemy_damage)


func enter() -> void:
	_animation_finished = false
	enemy.invulnerable = true
	
	_direction = enemy.global_position.direction_to(enemy.player.position)
	
	enemy.velocity = _direction * -knockback_speed
	enemy.set_direction(_direction)
	enemy.update_animation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)


func process(_delta: float) -> EnemyState:
	if _animation_finished:
		return next_state
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null


func physics(_delta: float) -> EnemyState:
	return null


func exit() -> void:
	enemy.invulnerable = false
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)


func _on_enemy_damage() -> void:
	state_machine.change_state(self)


func _on_animation_finished(_anim_name: StringName) -> void:
	_animation_finished = true
