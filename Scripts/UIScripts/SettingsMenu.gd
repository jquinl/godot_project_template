extends ColorRect
class_name SettingsMenu

signal settings_menu_closed
signal settings_menu_open
#Color rect background color and alpha
const ACTIVE_COLOR   : Color = Color(0.0,0.0,0.0,0.35)
const UNACTIVE_COLOR : Color = Color(0.0,0.0,0.0,0.0)

@onready var menu_panel = $MenuPanel

@onready var can_show  : bool = true


func _ready():
	#Makes the anchor point of the menu be centered for the tweening animation
	menu_panel.pivot_offset = menu_panel.size / 2.0
	#Makes the option menu color rect cover the entire screen so that anything under it cant be interacted with
	set_anchors_preset(Control.PRESET_FULL_RECT)
	offset_bottom = 0.0
	offset_top = 0.0
	offset_left = 0.0
	offset_right = 0.0
	
	panel_inactive()

func _on_exit_button_pressed():
	hide_settings_menu()
	UserSettings.save_settings()

func show_settings_menu():
	if not can_show : return

	visible = true
	var tween : Tween = create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self,"color",ACTIVE_COLOR,0.1).from(UNACTIVE_COLOR)
	tween.chain().tween_property(menu_panel,"scale",Vector2(1.0,1.0),0.5).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(panel_active)

func hide_settings_menu():
	if can_show : return
	var tween : Tween = create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(menu_panel,"scale",Vector2(0.0,0.0),0.1).set_trans(Tween.TRANS_EXPO)
	tween.chain().tween_property(self,"color",UNACTIVE_COLOR,0.1).from(ACTIVE_COLOR)
	tween.tween_callback(panel_inactive)

func panel_inactive():
	menu_panel.scale = Vector2(0.0,0.0)
	set_color(UNACTIVE_COLOR)
	visible = false
	can_show = true
	emit_signal("settings_menu_closed")

func panel_active():
	set_color(ACTIVE_COLOR)
	menu_panel.scale = Vector2(1.0,1.0)
	visible = true
	can_show = false
	emit_signal("settings_menu_open")

