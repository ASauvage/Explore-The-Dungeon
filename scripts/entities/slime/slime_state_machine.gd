extends AnimationTree


@onready var enemy: Enemy = get_owner()

var state: String
var is_moving: bool = false
var is_hit: bool = false
var is_dead: bool = false


func _ready() -> void:
	active = true


func _process(delta: float) -> void:
	state = get("parameters/playback").get_current_node()
	
	_define_variables()


func _define_variables() -> void:
	is_moving = true if enemy.velocity else false
