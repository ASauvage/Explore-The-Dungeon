class_name StateMachine
extends AnimationTree


const DIRECTIONAL_STATE: Array[String] = [
	"Idle",
	"Walk",
	"Attack",
	"Hit"
]


var is_walking: bool = false
var is_running: bool = false
var is_pushing: bool = false
var is_attacking: bool = false
var is_hit: bool = false
var is_dead: bool = false
