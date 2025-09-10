class_name StateAttack extends State


@onready var animation_player: AnimationPlayer = $"../../Graphics/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../AudioStreamPlayer"
@onready var idle: StateIdle = $"../Idle"

@export var attack_sound: AudioStream
@export var deceleration_speed: float = 5.0

var is_attacking: bool = false


func enter() -> void:
	player.update_animation("attack")
	animation_player.animation_finished.connect(end_attack)
	audio.stream = attack_sound
	is_attacking = true
	
	await get_tree().create_timer(0.3).timeout
	audio.play()


func process(_delta: float) -> State:
	player.velocity -= player.velocity * deceleration_speed * _delta
	
	if !is_attacking:
		return idle
	return null


func physics(_delta: float) -> State:
	return null


func handle_input(_event: InputEvent) -> State:
	return null


func exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)
	is_attacking = false


func end_attack(_anim_name: StringName) -> void:
	is_attacking = false
