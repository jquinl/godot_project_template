@tool
extends EditorScript
#Run me with ctrl+shift+X or 
#Right click on the rename_project.gd in the left panel (blue cog) > Run

var panel : ColorRect;
var line_edit : LineEdit

func _run():
	if Engine.is_editor_hint():
		var ctrl = get_editor_interface().get_base_control()
		panel = ColorRect.new()
		var crect = ColorRect.new()
		
		ctrl.add_child(panel)
		
		panel.set_anchors_preset(Control.PRESET_FULL_RECT,true)
		panel.color = Color(0.0,0.0,0.0,0.3)
		panel.add_child(crect)
		
		crect.color = Color(0.0,0.0,0.0,1.0)
		crect.set_anchors_preset(Control.PRESET_HCENTER_WIDE,true)
		crect.anchor_top = 0.42
		crect.anchor_bottom = 0.58
		crect.anchor_left = 0.44
		crect.anchor_right = 0.56
		crect.offset_top = 0.0
		crect.offset_bottom = 0.0
		crect.offset_left = 0.0
		crect.offset_right = 0.0
		var ok_button = Button.new()
		var cancel_button = Button.new()
		var label = Label.new()
		var vbox = VBoxContainer.new()
		
		line_edit = LineEdit.new()
		line_edit.alignment = HORIZONTAL_ALIGNMENT_CENTER
		line_edit.text = ProjectSettings.get_setting("application/config/name")
		label.text = "Set Project Name"
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		var margin = MarginContainer.new()
		crect.add_child(margin)
		margin.add_child(vbox)
		margin.add_theme_constant_override("margin_left",20)
		margin.add_theme_constant_override("margin_right",20)
		margin.set_anchors_preset(Control.PRESET_FULL_RECT)
		margin.offset_top = 0.0
		margin.offset_bottom = 0.0
		margin.offset_left = 0.3
		margin.offset_right = 0.7
		vbox.alignment = BoxContainer.ALIGNMENT_CENTER
		
		vbox.add_child(label)
		vbox.add_child(line_edit)
		vbox.add_child(ok_button)
		vbox.add_child(cancel_button)
		ok_button.text = "Accept"
		cancel_button.text = "Cancel"
		ok_button.mouse_filter = Control.MOUSE_FILTER_STOP
		ok_button.pressed.connect(_on_ok_pressed)
		cancel_button.pressed.connect(_on_cancel_pressed)
		panel.set_meta("_owner",self)

func _on_ok_pressed():
	ProjectSettings.set_setting("application/config/name",line_edit.text)
	if(ProjectSettings.get_setting("application/config/name","None") != "None"):
		ProjectSettings.set_setting("dotnet/project/assembly_name",line_edit.text)
	panel.queue_free()
func _on_cancel_pressed():
	panel.queue_free()
