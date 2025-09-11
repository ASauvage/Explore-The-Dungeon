class_name Player extends CharacterBody2D


const DIR_4: Array[Vector2] = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var animation_player: AnimationPlayer = $Graphics/AnimationPlayer
@onready var effect_animation_player: AnimationPlayer = $Graphics/EffectAnimationPlayer
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var hit_box: HitBox = $HitBox

@export_range(1, 20) var max_hitpoint: int = 6

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var hitpoint: int = max_hitpoint
var invulnarable: bool = false

signal on_damage(hurtbox: HurtBox)


func _ready() -> void:
	PlayerManager.player = self
	state_machine.initialize(self)
	hit_box.damaged.connect(_take_damage)
	update_hp(99)


func _process(_delta: float) -> void:
	pass


func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	
	move_and_slide()


func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	var direction_id: int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_dir = DIR_4[direction_id]
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	return true


func update_animation(state: String) -> void:
	animation_player.play(state + "_" + animation_direction())


func animation_direction() -> String:
	match cardinal_direction:
		Vector2.RIGHT:
			return "east"
		Vector2.LEFT:
			return "west"
		Vector2.UP:
			return "north"
		_:
			return "south"


func _take_damage(hurtbox: HurtBox) -> void:
	if invulnarable:
		return
	
	update_hp(-hurtbox.damage)
	if hitpoint > 0:
		on_damage.emit(hurtbox)
	else:
		on_damage.emit(hurtbox)
		update_hp(99)


func update_hp(delta: int) -> void:
	hitpoint = clampi(hitpoint + delta, 0, max_hitpoint)
	PlayerHud.update_hp(hitpoint, max_hitpoint)


func make_invunerable(_duration: float = 1.0) -> void:
	invulnarable = true
	hit_box.monitoring = false
	
	await get_tree().create_timer(_duration).timeout
	invulnarable = false
	hit_box.monitoring = true
