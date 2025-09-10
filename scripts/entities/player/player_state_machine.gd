class_name PlayerStateMachine extends AnimationTree


const DIRECTIONAL_STATE: Array[String] = ["Idle", "Walk", "Attack"]
const STATIC_STATE: Array[String] = ["Attack"]

@onready var player: Player = get_owner()

var state: String
var is_walking: bool = false
var is_attacking: bool = false


func _ready() -> void:
	active = true
	set("parameters/Idle/blend_position", player.direction)


func _process(_delta: float) -> void:
	state = get("parameters/playback").get_current_node()
	
	_define_variables()
	
	if player.velocity != Vector2.ZERO:
		for d_state in DIRECTIONAL_STATE:
			set("parameters/%s/blend_position" % d_state, player.direction)


func _define_variables() -> void:
	is_walking = true if player.velocity else false
	is_attacking = Input.is_action_just_pressed("attack")
