extends ColorRect
class_name  PauseMenu

signal  pause_menu_open
signal  pause_menu_closed

@onready var settings_menu : SettingsMenu = $SettingsMenu
@onready var current_scene = $".."

const ACTIVE_COLOR   : Color = Color(0.0,0.0,0.0,0.35)
const UNACTIVE_COLOR : Color = Color(0.0,0.0,0.0,0.0)

@onready var can_show  : bool = true

func ready():
	set_color(UNACTIVE_COLOR)
	visible = false
	can_show = true

func show_pause_menu():
	if not can_show :return
	get_tree().paused = true
	visible = true
	var tween : Tween = create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self,"color",ACTIVE_COLOR,0.1).from(UNACTIVE_COLOR)
	tween.tween_callback(panel_active)

func hide_pause_menu():
	if can_show : return
	var tween : Tween = create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self,"color",UNACTIVE_COLOR,0.1).from(ACTIVE_COLOR)
	tween.tween_callback(panel_inactive)
	return tween

func panel_inactive():
	set_color(UNACTIVE_COLOR)
	visible = false
	can_show = true
	emit_signal("pause_menu_closed")
	get_tree().paused = false

func panel_active():
	get_tree().paused = true
	set_color(ACTIVE_COLOR)
	visible = true
	can_show = false
	emit_signal("pause_menu_open")

func _on_continue_button_pressed():
	hide_pause_menu()

func _on_main_menu_button_pressed():
	await hide_pause_menu().finished
	SceneManager.load_scene(owner,"res://Scenes/MainScene/MainScene.tscn")

func _on_settings_button_pressed():
	settings_menu.show_settings_menu()

func _on_quit_pressed():
	get_tree().quit()
