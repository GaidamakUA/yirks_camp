extends Node

const SETTINGS_DIR = "user://settings/"
const CONFIG_FILE = "controls.json"

var actions := PoolStringArray(["ui_up", "ui_down", "ui_left", "ui_right", "interact", "dash"])

func _ready():
	_load_control_scheme()

func _load_control_scheme():
	var save_game = File.new()
	if not save_game.file_exists(_get_keybindings_file()):
		return # Error! We don't have a save to load.
	save_game.open(_get_keybindings_file(), File.READ)
	var keybindings: Dictionary = parse_json(save_game.get_line())
	for action in keybindings.keys():
		InputMap.action_erase_events(action)
		var event: InputEventKey = InputEventKey.new()
		event.scancode = keybindings[action]
		InputMap.action_add_event(action, event)
		print(action, ", ", OS.get_scancode_string(event.scancode), ", ", event.scancode)

func _get_keybindings_file() -> String:
	return str(SETTINGS_DIR, CONFIG_FILE)

func save_control_scheme():
	var keymap: Dictionary = _get_keymap(actions)
	
	var dir = Directory.new()
	if not dir.dir_exists(SETTINGS_DIR):
		dir.make_dir_recursive(SETTINGS_DIR)
	var file = File.new()
	file.open(_get_keybindings_file(), File.WRITE)
	file.store_line(to_json(keymap))
	file.close()

func _get_keymap(actions: PoolStringArray) -> Dictionary:
	var dictionary := Dictionary()
	for action in actions:
		dictionary[action] = _get_code_for_action(action)
	return dictionary

func _get_code_for_action(action_name: String) -> int:
	var input_event := InputMap.get_action_list(action_name)[0] as InputEventKey
	return input_event.scancode
