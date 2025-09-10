class_name Player extends CharacterBody2D


const DIR_4: Array[Vector2] = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var animation_player: AnimationPlayer = $Graphics/AnimationPlayer
@onready var state_machine: PlayerStateMachine = $StateMachine

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO


func _ready() -> void:
	state_machine.initialize(self)


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
