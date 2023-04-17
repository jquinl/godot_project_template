extends Node3D

@onready var pause_menu : PauseMenu = $PauseMenu

func _ready():
	pause_menu.pause_menu_closed.connect(closed_pause_menu)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			open_pause()

func open_pause():
	pause_menu.show_pause_menu()

func closed_pause_menu():
	pass

func _on_button_pressed():
	get_tree().quit()
