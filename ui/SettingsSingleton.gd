extends Node

const SETTINGS_DIR = "user://settings/"
const CONTROLS_FILE = "controls.json"
const SETTINGS_FILE = "settings.json"

var actions := PoolStringArray(["ui_up", "ui_down", "ui_left", "ui_right", "interact", "dash"])
var FULSCREEN_KEY = "fulscreen"
var LANGUAGE_KEY = "language"

func _ready():
	_load_control_scheme()
	_load_settings()

func _load_control_scheme():
	var keybindings: Dictionary = _load_data_from_file(CONTROLS_FILE)
	for action in keybindings.keys():
		InputMap.action_erase_events(action)
		var event: InputEventKey = InputEventKey.new()
		event.scancode = keybindings[action]
		InputMap.action_add_event(action, event)
		print(action, ", ", OS.get_scancode_string(event.scancode), ", ", event.scancode)

func _load_settings():
	var data = _load_data_from_file(SETTINGS_FILE)
	if data:
		OS.window_fullscreen = data[FULSCREEN_KEY]
		TranslationServer.set_locale(data[LANGUAGE_KEY])

func _load_data_from_file(file_name: String):
	var save_game = File.new()
	var full_name = str(SETTINGS_DIR, file_name)
	if not save_game.file_exists(full_name):
		return # Error! We don't have a save to load.
	save_game.open(full_name, File.READ)
	return parse_json(save_game.get_line())

func save_control_scheme():
	var data := Dictionary()
	for action in actions:
		data[action] = _get_code_for_action(action)
	_save_data_to_file(data, CONTROLS_FILE)

func _get_code_for_action(action_name: String) -> int:
	var input_event := InputMap.get_action_list(action_name)[0] as InputEventKey
	return input_event.scancode

func save_settings():
	var data := Dictionary()
	data[FULSCREEN_KEY] = OS.window_fullscreen
	data[LANGUAGE_KEY] = TranslationServer.get_locale()
	_save_data_to_file(data, SETTINGS_FILE)

func _save_data_to_file(data: Dictionary, file_name: String):
	var dir = Directory.new()
	if not dir.dir_exists(SETTINGS_DIR):
		dir.make_dir_recursive(SETTINGS_DIR)
	var file = File.new()
	var full_name = str(SETTINGS_DIR, file_name)
	file.open(full_name, File.WRITE)
	file.store_line(to_json(data))
	file.close()

func save_level():
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	var node_data = []
	for node in save_nodes:
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
		node_data.append(node.save())
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_line(to_json({"saved_objects": node_data}))
	save_game.close()
