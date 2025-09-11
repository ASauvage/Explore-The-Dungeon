extends CanvasLayer


@onready var save_button: TextureButton = $Menu/LeftPage/VBoxContainer/SaveButton
@onready var load_button: TextureButton = $Menu/LeftPage/VBoxContainer/LoadButton
@onready var quit_button: TextureButton = $Menu/LeftPage/VBoxContainer/QuitButton

var is_paused: bool = false


func _ready() -> void:
	visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause_menu()
		get_viewport().set_input_as_handled()


func toggle_pause_menu() -> void:
	get_tree().paused = !get_tree().paused
	visible = !visible
	print("pause")
