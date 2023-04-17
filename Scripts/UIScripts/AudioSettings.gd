extends MarginContainer

@onready var master_slider  : HSlider = $VBoxContainer/MasterMargin/VBoxContainer/HBoxContainer2/MasterSlider
@onready var music_slider   : HSlider = $VBoxContainer/MusicMargin/VBoxContainer/HBoxContainer2/MusicSlider
@onready var effects_slider : HSlider = $VBoxContainer/EffectsMargin/VBoxContainer/HBoxContainer2/EffectsSlider


# Called when the node enters the scene tree for the first time.
func _ready():
	update_slider_values()

func update_slider_values():
	master_slider.value  = UserSettings.get_master_volume()
	music_slider.value   = UserSettings.get_master_volume()
	effects_slider.value = UserSettings.get_master_volume()

func _on_master_slider_value_changed(value):
	UserSettings.set_master_volume(value)
func _on_effects_slider_value_changed(value):
	UserSettings.set_music_volume(value)
func _on_music_slider_value_changed(value):
	UserSettings.set_effects_volume(value)
