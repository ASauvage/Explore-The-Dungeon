class_name Entity
extends CharacterBody2D


@onready var animation_tree: StateMachine = $Graphics/AnimationTree
@onready var state_machine: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

@export var hitpoint: int = 5
@export var speed = 100.0
var direction: Vector2 = Vector2.ZERO
var is_attacking: bool = false


func _ready() -> void:
	animation_tree.active = true


func _process(_delta: float) -> void:
	update_animation_parameters()
	update_state_variables()


func _physics_process(delta: float) -> void:
	move_and_slide()


func update_animation_parameters():
	animation_tree.is_walking = velocity != Vector2.ZERO
	animation_tree.is_attacking = Input.is_action_just_pressed("attack")
	
	if direction != Vector2.ZERO and !is_attacking:
		for state in animation_tree.DIRECTIONAL_STATE:
			animation_tree.set("parameters/%s/blend_position" % state, direction)


func update_state_variables() -> void:
	var state = state_machine.get_current_node()
	is_attacking = true if state == "Attack" else false
