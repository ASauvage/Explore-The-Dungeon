extends CharacterBody2D
class_name Player


@onready var animation_tree: StateMachine = $Graphics/AnimationTree
@onready var state_machine: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
@onready var inventory_ui: CanvasLayer = $InventoryCanva

@export var hitpoint: int = 5
@export var speed: float = 75.0
@export var inventory: Inventory


var direction: Vector2 = Vector2.ZERO
var is_attacking: bool = false
var is_pushing: bool = false


func _ready() -> void:
	animation_tree.active = true
	inventory_ui.visible = false


func _process(_delta: float) -> void:
	update_animation_parameters()
	if Input.is_action_just_pressed("interact"):
		on_hit(4)


func _physics_process(_delta: float) -> void:
	if get_tree().paused:
		return
	
	# movement inputs
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	if direction and !is_attacking:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory") or (inventory_ui.visible and event.is_action_pressed("ui_cancel")):
		inventory_ui.visible = !inventory_ui.visible
		get_tree().paused = !get_tree().paused


func update_animation_parameters() -> void:
	var current_state = state_machine.get_current_node()
	
	animation_tree.is_hit = false
	animation_tree.is_walking = velocity != Vector2.ZERO
	animation_tree.is_attacking = Input.is_action_just_pressed("attack")
	
	if direction != Vector2.ZERO and !is_attacking:
		for state in animation_tree.DIRECTIONAL_STATE:
			animation_tree.set("parameters/%s/blend_position" % state, direction)
	
	is_attacking = true if current_state == "Attack" else false


func on_hit(dammage: int = 1) -> void:
	hitpoint -= dammage
	animation_tree.is_hit = true
	if hitpoint <= 0:
		animation_tree.is_dead = true
