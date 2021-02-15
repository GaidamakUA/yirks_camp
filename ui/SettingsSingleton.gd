extends Node

const SETTINGS_DIR = "user://settings/"
const CONTROLS_FILE = "controls.json"
const SETTINGS_FILE = "settings.json"
const SAVE_DIR = "user://saves/"
const SAVE_GAME = "savegame.json"

var actions := PoolStringArray(["ui_up", "ui_down", "ui_left", "ui_right", "interact", "dash"])
var FULSCREEN_KEY = "fulscreen"
var LANGUAGE_KEY = "language"

func _ready():
	_load_control_scheme()
	_load_settings()

func _load_control_scheme():
	if not _is_file_exist(SETTINGS_DIR, CONTROLS_FILE):
		return
	var keybindings: Dictionary = _load_data_from_file(SETTINGS_DIR, CONTROLS_FILE)
	for action in keybindings.keys():
		InputMap.action_erase_events(action)
		var event: InputEventKey = InputEventKey.new()
		event.scancode = keybindings[action]
		InputMap.action_add_event(action, event)
		print(action, ", ", OS.get_scancode_string(event.scancode), ", ", event.scancode)

func _load_settings():
	if not _is_file_exist(SETTINGS_DIR, SETTINGS_FILE):
		return
	var data = _load_data_from_file(SETTINGS_DIR, SETTINGS_FILE)
	if data:
		OS.window_fullscreen = data[FULSCREEN_KEY]
		TranslationServer.set_locale(data[LANGUAGE_KEY])

func _load_data_from_file(dir_name: String, file_name: String):
	var save_game = File.new()
	var full_name = str(dir_name, file_name)
	if not save_game.file_exists(full_name):
		return # Error! We don't have a save to load.
	save_game.open(full_name, File.READ)
	return parse_json(save_game.get_line())

func _is_file_exist(dir_name: String, file_name: String) -> bool:
	var save_game = File.new()
	var full_name = str(dir_name, file_name)
	return save_game.file_exists(full_name)

func save_control_scheme():
	var data := Dictionary()
	for action in actions:
		data[action] = _get_code_for_action(action)
	_save_data_to_file(data, SETTINGS_DIR, CONTROLS_FILE)

func _get_code_for_action(action_name: String) -> int:
	var input_event := InputMap.get_action_list(action_name)[0] as InputEventKey
	return input_event.scancode

func save_settings():
	var data := Dictionary()
	data[FULSCREEN_KEY] = OS.window_fullscreen
	data[LANGUAGE_KEY] = TranslationServer.get_locale()
	_save_data_to_file(data, SETTINGS_DIR, SETTINGS_FILE)

func _save_data_to_file(data: Dictionary, dir_name: String, file_name: String):
	var dir = Directory.new()
	if not dir.dir_exists(dir_name):
		dir.make_dir_recursive(dir_name)
	var file = File.new()
	var full_name = str(dir_name, file_name)
	file.open(full_name, File.WRITE)
	file.store_line(to_json(data))
	file.close()

func save_level(save_data: Dictionary):
	_save_data_to_file(save_data, SAVE_DIR, SAVE_GAME)

func load_level():
	var save_data = _load_data_from_file(SAVE_DIR, SAVE_GAME)
	get_tree().change_scene(save_data["levelscene"])
	call_deferred("init_current_scene_with_data", save_data)

func init_current_scene_with_data(save_data: Dictionary):
	get_tree().current_scene.load_data(save_data)
