extends MarginContainer
@onready var aa_option = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer2/MSAAOption
@onready var shadows_option = $MarginContainer/VBoxContainer/MarginContainer2/HBoxContainer2/ShadowsOption

func _ready():
	aa_option.item_selected.connect(_on_aa_item_selected)
	shadows_option.item_selected.connect(_on_shadows_item_selected)
	update_button_values()

func update_button_values():
	
	var aa = UserSettings.get_aa_settings()
	if(aa == UserSettings.AAQuality.DISABLED):
		aa_option.selected = 0
	elif(aa == UserSettings.AAQuality.FXAA):
		aa_option.selected = 1
	elif(aa == UserSettings.AAQuality.MSAA2X):
		aa_option.selected = 2
	elif(aa == UserSettings.AAQuality.MSAA4X):
		aa_option.selected = 3
	elif(aa == UserSettings.AAQuality.MSAA8X):
		aa_option.selected = 4
	
	var gr = UserSettings.get_shadows()
	if(gr == UserSettings.ShadowQuality.DISABLED):
		shadows_option.selected = 0
	if(gr == UserSettings.ShadowQuality.LOW):
		shadows_option.selected = 1
	if(gr == UserSettings.ShadowQuality.MEDIUM):
		shadows_option.selected = 2
	if(gr == UserSettings.ShadowQuality.HIGH):
		shadows_option.selected = 3

func _on_aa_item_selected(index : int):
	if index == 0:
		UserSettings.set_aa_settings(UserSettings.AAQuality.DISABLED)
	if index == 1:
		UserSettings.set_aa_settings(UserSettings.AAQuality.FXAA)
	if index == 2:
		UserSettings.set_aa_settings(UserSettings.AAQuality.MSAA2X)
	if index == 3:
		UserSettings.set_aa_settings(UserSettings.AAQuality.MSAA4X)
	if index == 4:
		UserSettings.set_aa_settings(UserSettings.AAQuality.MSAA8X)

func _on_shadows_item_selected(index : int):
	if index == 0:	
		UserSettings.set_shadows(UserSettings.ShadowQuality.DISABLED)
	if index == 1:
		UserSettings.set_shadows(UserSettings.ShadowQuality.LOW)
	if index == 2:
		UserSettings.set_shadows(UserSettings.ShadowQuality.MEDIUM)
	if index == 3:
		UserSettings.set_shadows(UserSettings.ShadowQuality.HIGH)
