class_name Enemy extends CharacterBody2D


const DIR: Array[Vector2] = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hitpoint: int = 1

var direction: Vector2 = Vector2.DOWN

signal on_damage()


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _physics_process(_delta: float) -> void:
	move_and_slide()
