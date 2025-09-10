class_name PlayerCamera extends Camera2D


func _ready() -> void:
	LevelManager.tilemap_bounds_changed.connect(update_limit)
	update_limit(LevelManager.current_tilemap_bounds)


func update_limit(bounds: Array[Vector2]) -> void:
	if bounds.is_empty():
		return

	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)
