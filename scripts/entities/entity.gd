extends CharacterBody2D
class_name Entity


@onready var animation_tree: StateMachine = $Graphics/AnimationTree
@onready var state_machine: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

@export var hitpoint: int
@export var speed: float

var direction: Vector2 = Vector2.ZERO
var is_attacking: bool = false


func _ready() -> void:
	animation_tree.active = true


func _process(_delta: float) -> void:
	update_animation_parameters()


func _physics_process(_delta: float) -> void:
	if direction and !is_attacking:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()


func on_hit(dammage: int) -> void:
	hitpoint -= dammage
	animation_tree.is_hit = true
	if hitpoint <= 0:
		animation_tree.is_dead = true


func update_animation_parameters() -> void:
	var current_state = state_machine.get_current_node()
	
	animation_tree.is_hit = false
	animation_tree.is_walking = velocity != Vector2.ZERO
	animation_tree.is_attacking = Input.is_action_just_pressed("attack")
	
	if direction != Vector2.ZERO and !is_attacking:
		for state in animation_tree.DIRECTIONAL_STATE:
			animation_tree.set("parameters/%s/blend_position" % state, direction)
	
	is_attacking = true if current_state == "Attack" else false
