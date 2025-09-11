@tool
class_name LevelTransition extends Area2D


enum SIDE {RIGHT, DOWN, LEFT, UP}

@onready var collision_shape: CollisionShape2D = $CollisionShape

@export_file("*.tscn") var level
@export var target_transition_area: String = "LevelTransition"
@export_category("Collision Area Settings")
@export_range(1, 12, 1, "or_greater") var size: int = 2:
	set(_value):
		size = _value
		update_area()

@export var side: SIDE = SIDE.DOWN:
	set(_value):
		side = _value
		update_area()


func _ready() -> void:
	update_area()
	
	if Engine.is_editor_hint():
		return
	
	monitoring = false
	_place_player()
	
	await LevelManager.level_loaded
	
	monitoring = true


func update_area() -> void:
	var new_rect: Vector2 = Vector2(16, 16)
	var new_position: Vector2 = Vector2.ZERO
	
	match side:
		SIDE.RIGHT:
			new_rect.y *= size
			new_position.x += 8
		SIDE.DOWN:
			new_rect.x *= size
			new_position.y += 8
		SIDE.LEFT:
			new_rect.y *= size
			new_position.x -= 8
		SIDE.UP:
			new_rect.x *= size
			new_position.y -= 8
	
	if not collision_shape:
		collision_shape = get_node("CollisionShape")
	
	collision_shape.shape.size = new_rect
	collision_shape.position = new_position


func _place_player() -> void:
	if name != LevelManager.target_transition:
		return
	PlayerManager.set_player_position(global_position + LevelManager.position_offset)


func get_offset() -> Vector2:
	var offset: Vector2 = Vector2.ZERO
	var player_pos = PlayerManager.player.global_position
	
	if side in [SIDE.LEFT, SIDE.RIGHT]:
		offset.y = player_pos.y - global_position.y
		offset.x = 8
		if side == SIDE.LEFT:
			offset.x *= -1
	else:
		offset.x = player_pos.x - global_position.x
		offset.y = 8
		if side == SIDE.UP:
			offset.y *= -1
	
	return offset


func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	
	LevelManager.load_new_level(level, target_transition_area, get_offset())
