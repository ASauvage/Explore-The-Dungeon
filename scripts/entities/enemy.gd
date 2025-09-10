class_name Enemy extends CharacterBody2D


const DIR_4: Array[Vector2] = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var animation_player: AnimationPlayer = $Graphics/AnimationPlayer
@onready var state_machine: EnemyStateMachine = $StateMachine
@onready var hit_box: HitBox = $HitBox

@export var hitpoint: int = 1
@export var damage: int = 1

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var player: Player
var invulnerable: bool = false

signal on_damage()


func _ready() -> void:
	state_machine.initialize(self)
	player = PlayerManager.player
	hit_box.damaged.connect(_take_damage)


func _process(_delta: float) -> void:
	pass


func _physics_process(_delta: float) -> void:
	move_and_slide()


func set_direction(_new_direction: Vector2) -> bool:
	direction = _new_direction
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
		_:
			return "west"


func _take_damage(damage: int) -> void:
	if invulnerable:
		return
	hitpoint -= damage
	on_damage.emit()
