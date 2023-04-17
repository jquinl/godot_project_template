extends Node
class_name GlobalUserSettings

const CFG_FILE_PATH:String = "user://settings.json"

enum ShadowQuality{
	DISABLED = 0,
	LOW = 1,
	MEDIUM = 2,
	HIGH = 3
}
enum AAQuality{
	DISABLED = 0,
	FXAA = 1,
	MSAA2X = 2,
	MSAA4X = 3,
	MSAA8X = 4
}
enum DisplayMode{
	WINDOW = 0,
	MAX_WINDOW = 1,
	BORDERLES = 2,
	FULLSCREEN = 3
}
enum DisplayWindow{
	_1280X720 = 0,
	_1920X1080 = 1,
	_2560X1440 = 2,
	_3840X2460 = 3
}
enum VsyncOption{
	DISABLED = 0,
	ENABLED = 1,
	ADAPTATIVE = 2,
	MAILBOX = 3
}
var default_settings={
	"display":{
		"mode"  : DisplayMode.BORDERLES,
		"window": DisplayWindow._1920X1080,
		"vsync" : VsyncOption.ENABLED,
	},
	"graphics":{
		"aa"     : AAQuality.MSAA2X,
		"shadows": ShadowQuality.LOW
	},
	"audio":{
		"master_v"  : 0.0,
		"music_v"   : 0.0,
		"effects_v" : 0.0	
	},
}
var user_settings={
}
func _ready():
	load_settings()
	apply_user_settings()

func save_settings():
	var file = FileAccess.open(CFG_FILE_PATH, FileAccess.WRITE)
	file.store_line(JSON.stringify(user_settings))
	
func load_settings():
	if not FileAccess.file_exists(CFG_FILE_PATH):
		user_settings = default_settings
		return 
	var settings_file = FileAccess.get_file_as_string(CFG_FILE_PATH)
	var json_settings = JSON.parse_string(settings_file)
	if json_settings != null:
		user_settings = json_settings

func apply_user_settings():
	if not user_settings.has_all(["display","graphics","audio"]):
		user_settings = default_settings
	if not user_settings["display"].has_all(["mode","window","vsync"]):
		user_settings["display"] = default_settings["display"]
	if not user_settings["graphics"].has_all(["aa","shadows"]):
		user_settings["graphics"] = default_settings["graphics"]
	if not user_settings["audio"].has_all(["master_v","master_v","master_v"]):
		user_settings["audio"] = default_settings["audio"]
	
	set_display_mode(user_settings["display"]["mode"])
	set_display_window(user_settings["display"]["window"])
	set_vsync_option(user_settings["display"]["vsync"])
	set_aa_settings(user_settings["graphics"]["aa"])
	set_shadows(user_settings["graphics"]["shadows"])
	set_master_volume(user_settings["audio"]["master_v"])
	set_music_volume(user_settings["audio"]["music_v"])
	set_effects_volume(user_settings["audio"]["effects_v"])

###Display------------------------------------------
func set_display_mode(dm : DisplayMode):
	if dm == DisplayMode.WINDOW:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if dm == DisplayMode.MAX_WINDOW:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	if dm == DisplayMode.BORDERLES:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if dm == DisplayMode.FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	user_settings["display"]["mode"] = dm
func get_display_mode():
	return user_settings["display"]["mode"]

func set_display_window(dw : DisplayWindow):
	if dw == DisplayWindow._1280X720:
		DisplayServer.window_set_size(Vector2i(1280,720))
	if dw == DisplayWindow._1920X1080:
		DisplayServer.window_set_size(Vector2i(1920,1080))
	if dw == DisplayWindow._2560X1440:
		DisplayServer.window_set_size(Vector2i(2560,1440))
	if dw == DisplayWindow._3840X2460:
		DisplayServer.window_set_size(Vector2i(3840,2160))
	user_settings["display"]["window"] = dw

func get_display_window():
	return user_settings["display"]["window"]

func set_vsync_option(vs : VsyncOption):
	if vs == VsyncOption.DISABLED:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	if vs == VsyncOption.ENABLED:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	if vs == VsyncOption.ADAPTATIVE:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
	if vs == VsyncOption.MAILBOX:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_MAILBOX)
	user_settings["display"]["vsync"] = vs

func get_vsync_option():
	return user_settings["display"]["vsync"]
###Graphics-----------------------------------------
func set_aa_settings(aa : AAQuality):
	if aa == AAQuality.DISABLED:
		get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED
		get_viewport().msaa_3d = Viewport.MSAA_DISABLED
	if aa == AAQuality.FXAA:
		get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_FXAA
		get_viewport().msaa_3d = Viewport.MSAA_DISABLED
	if aa == AAQuality.MSAA2X:
		get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED
		get_viewport().msaa_3d = Viewport.MSAA_2X
	if aa == AAQuality.MSAA4X:
		get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED
		get_viewport().msaa_3d = Viewport.MSAA_4X
	if aa == AAQuality.MSAA8X:
		get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED
		get_viewport().msaa_3d = Viewport.MSAA_8X

	user_settings["graphics"]["aa"] = aa

func get_aa_settings():
	return user_settings["graphics"]["aa"]
	
func set_shadows(s: ShadowQuality):
	if(s == ShadowQuality.DISABLED):
		get_tree().call_group("DirectionalLightGroup","set_shadow",false)
	elif(s == ShadowQuality.LOW):
		get_tree().call_group("DirectionalLightGroup","set_shadow",true)
		get_tree().call_group("DirectionalLightGroup","set_shadow_mode",0)
	elif(s == ShadowQuality.MEDIUM):
		get_tree().call_group("DirectionalLightGroup","set_shadow",true)
		get_tree().call_group("DirectionalLightGroup","set_shadow_mode",1)
	elif(s == ShadowQuality.HIGH):
		get_tree().call_group("DirectionalLightGroup","set_shadow",true)
		get_tree().call_group("DirectionalLightGroup","set_shadow_mode",2)
	user_settings["graphics"]["shadows"] = s

func get_shadows():
	return user_settings["graphics"]["shadows"]

func set_master_volume(value : float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value)
	user_settings["audio"]["master_v"] = value

func get_master_volume():
	return user_settings["audio"]["master_v"]

func set_music_volume(value : float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),value)
	user_settings["audio"]["music_v"] = value

func get_music_volume():
	return user_settings["audio"]["music_v"]

func set_effects_volume(value : float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"),value)
	user_settings["audio"]["effects_v"] = value

func get_effects_volume():
	return user_settings["audio"]["effects_v"]
