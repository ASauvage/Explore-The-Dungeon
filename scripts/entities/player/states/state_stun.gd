class_name StateStun extends State


@export var knockback_speed: float = 200.0
@export var deceleration_speed: float = 10.0
@export var invulnarable_duration: float = 1.0

@onready var idle: State = $"../Idle"

var hurtbox: HurtBox
var _direction: Vector2
var next_state: State = null


func init() -> void:
	player.on_damage.connect(_take_damage)


func enter() -> void:
	player.animation_player.animation_finished.connect(_on_animation_finished)
	
	_direction = player.global_position.direction_to(hurtbox.global_position)
	player.velocity = _direction * -knockback_speed
	player.set_direction()
	player.update_animation("hit")
	
	player.make_invunerable(invulnarable_duration)
	player.effect_animation_player.play("invulnarable_blink")


func process(_delta: float) -> State:
	return next_state


func physics(_delta: float) -> State:
	player.velocity -= player.velocity * deceleration_speed * _delta
	return null


func handle_input(_event: InputEvent) -> State:
	return null


func exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect(_on_animation_finished)


func _take_damage(_hurtbox: HurtBox) -> void:
	hurtbox = _hurtbox
	state_machine.change_state(self)


func _on_animation_finished(_anim_name: StringName) -> void:
	next_state = idle
