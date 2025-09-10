class_name Player extends CharacterBody2D


@onready var animation_tree: PlayerStateMachine = $AnimationTree
@export var speed: float = 75.0
@export var decelarate_speed: float = 5.0

var direction: Vector2 = Vector2.DOWN


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	_handle_movements(delta)
	move_and_slide()


func _handle_movements(delta: float) -> void:
	if !animation_tree.state in animation_tree.STATIC_STATE:
		direction = Input.get_vector("left", "right", "up", "down")
		velocity = direction * speed
	else:
		velocity -= velocity * decelarate_speed * delta
