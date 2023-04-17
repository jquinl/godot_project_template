extends VBoxContainer

@onready var settings_menu = $"../SettingsMenu"

func _on_play_button_pressed():
	SceneManager.load_scene(owner,"res://Scenes/GameScenes/TestsScene.tscn")

func _on_settings_button_pressed():
	settings_menu.show_settings_menu()

func _on_quit_button_pressed():
	get_tree().quit()

