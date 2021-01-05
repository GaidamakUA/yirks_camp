extends Panel

signal controls_changed

var recording_action

func _ready():
	update_keys()

func update_keys():
	init_button("ui_up", $MarginContainer/VBoxContainer/ScrollContainer/GridContainer/Up)
	init_button("ui_down", $MarginContainer/VBoxContainer/ScrollContainer/GridContainer/Down)
	init_button("ui_left", $MarginContainer/VBoxContainer/ScrollContainer/GridContainer/Left)
	init_button("ui_right", $MarginContainer/VBoxContainer/ScrollContainer/GridContainer/Right)
	init_button("interact", $MarginContainer/VBoxContainer/ScrollContainer/GridContainer/Interact)
	init_button("dash", $MarginContainer/VBoxContainer/ScrollContainer/GridContainer/Dash)

func _input(event):
	if recording_action != null && event is InputEventKey:
		InputMap.action_erase_events(recording_action)
		InputMap.action_add_event(recording_action, event)
		recording_action = null
		update_keys()

func init_button(action_name: String, button: Button):
	if recording_action != null:
		button.disconnect("pressed", self, "rebind_action")
	else:
		button.connect("pressed", self, "rebind_action", [action_name])

	if action_name == recording_action:
		button.text = "..."
	else:
		var code = get_code_for_action(action_name)
		var key_string = OS.get_scancode_string(code)
		button.text = key_string

func rebind_action(action_name):
	recording_action = action_name
	update_keys()

func get_code_for_action(action_name: String) -> int:
	var input_event := InputMap.get_action_list(action_name)[0] as InputEventKey
	return input_event.scancode

func _on_ClosePopup_pressed():
	hide()
	emit_signal("controls_changed")
