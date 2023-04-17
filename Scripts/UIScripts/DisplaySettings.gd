extends MarginContainer

@onready var vsinc_option = $MarginContainer/VBoxContainer/MarginContainer3/HBoxContainer3/VsincOption
@onready var resolution_option = $MarginContainer/VBoxContainer/MarginContainer2/HBoxContainer/ResolutionOption
@onready var display_mode_option = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer2/DisplayModeOption
@onready var keep_changes_panel = $KeepChangesPanel
@onready var keep_changes_label:Label = $KeepChangesPanel/KeepChangesLabel

const KEEP_CHG_TIME : float = 10.0
@onready var keep_time : float = KEEP_CHG_TIME
@onready var keep_chg : bool = false

@onready var keep_dict = {
	"w_mode" : UserSettings.get_display_mode(),
	"w_size" : UserSettings.get_display_window(),
	"v_mode" : UserSettings.get_vsync_option()
}
var rdy : bool = false
func _ready():
	keep_changes_panel.visible = false
	rdy = true
	update_button_values()

func _notification(what):
	if what == NOTIFICATION_VISIBILITY_CHANGED and rdy :
		keep_changes_panel.visible = false
		update_button_values()

func update_button_values():
	var w_mode = UserSettings.get_display_mode()
	if w_mode == UserSettings.DisplayMode.WINDOW:
		display_mode_option.selected = 0
	elif w_mode == UserSettings.DisplayMode.MAX_WINDOW:
		display_mode_option.selected = 1
	elif w_mode == UserSettings.DisplayMode.BORDERLES:
		display_mode_option.selected = 2
	elif w_mode == UserSettings.DisplayMode.FULLSCREEN:
		display_mode_option.selected = 3

	var windowsize = UserSettings.get_display_window()
	if windowsize == UserSettings.DisplayWindow._1280X720:
		resolution_option.selected = 0
	elif windowsize == UserSettings.DisplayWindow._1920X1080:
		resolution_option.selected = 1
	elif windowsize == UserSettings.DisplayWindow._2560X1440:
		resolution_option.selected = 2
	elif windowsize == UserSettings.DisplayWindow._3840X2460:
		resolution_option.selected = 3
	
	var v_mode = UserSettings.get_vsync_option()
	if v_mode == UserSettings.VsyncOption.DISABLED:
		vsinc_option.selected = 0
	elif v_mode == UserSettings.VsyncOption.ENABLED:
		vsinc_option.selected = 1
	elif v_mode == UserSettings.VsyncOption.ADAPTATIVE:
		vsinc_option.selected = 2
	elif v_mode == UserSettings.VsyncOption.MAILBOX:
		vsinc_option.selected = 3

func _on_display_mode_option_item_selected(index):
	update_revert_dict()
	if index == 0:
		UserSettings.set_display_mode(UserSettings.DisplayMode.WINDOW)
	if index == 1:
		UserSettings.set_display_mode(UserSettings.DisplayMode.MAX_WINDOW)
	if index == 2:
		UserSettings.set_display_mode(UserSettings.DisplayMode.BORDERLES)
	if index == 3:
		UserSettings.set_display_mode(UserSettings.DisplayMode.FULLSCREEN)
	show_keep_changes()

func _on_resolution_option_item_selected(index):
	update_revert_dict()
	if index == 0:
		UserSettings.set_display_window(UserSettings.DisplayWindow._1280X720)
	if index == 1:
		UserSettings.set_display_window(UserSettings.DisplayWindow._1920X1080)
	if index == 2:
		UserSettings.set_display_window(UserSettings.DisplayWindow._2560X1440)
	if index == 3:
		UserSettings.set_display_window(UserSettings.DisplayWindow._3840X2460)
	show_keep_changes()

func _on_vsinc_option_item_selected(index):
	update_revert_dict()
	if index == 0:
		UserSettings.set_vsync_option(UserSettings.VsyncOption.DISABLED)
	if index == 1:
		UserSettings.set_vsync_option(UserSettings.VsyncOption.ENABLED)
	if index == 2:
		UserSettings.set_vsync_option(UserSettings.VsyncOption.ADAPTATIVE)
	if index == 3:
		UserSettings.set_vsync_option(UserSettings.VsyncOption.MAILBOX)
	show_keep_changes()

func _on_keep_changes_pressed():
	keep_chg = true
	UserSettings.save_settings()
	keep_changes_panel.visible = false

func update_revert_dict():
	keep_dict = {
		"w_mode" : UserSettings.get_display_mode(),
		"w_size" : UserSettings.get_display_window(),
		"v_mode" : UserSettings.get_vsync_option()
	}

func revert_to_dict():
	UserSettings.set_display_mode(keep_dict["w_mode"])
	UserSettings.set_display_window(keep_dict["w_size"])
	UserSettings.set_vsync_option(keep_dict["v_mode"])
	UserSettings.save_settings()
	update_button_values()

func show_keep_changes():
	keep_chg = false
	keep_time = KEEP_CHG_TIME
	keep_changes_panel.visible = true
	update_timer()

func update_timer():
	if(keep_chg):
		return
	keep_changes_label.text =str(int(keep_time))
	if(keep_time < 1.0 ):
		keep_changes_panel.visible = false
		revert_to_dict()
		return
	await get_tree().create_timer(1.0).timeout
	keep_time -= 1.0
	update_timer()
