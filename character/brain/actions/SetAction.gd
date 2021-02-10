extends AtomicAction

# Execute one action from set. Base class, do not instantiate.
class_name SetAction

var actions: Array
var current_action

func _ready():
	_init_actions()

func _init_actions():
	actions = []
	for child in children:
		if child is AtomicAction:
			actions.append(child)

func _perform():
	_notify_done()

func drop():
	if current_action:
		current_action.drop()

func _to_string() -> String:
	return "SetAction should be overwritten"

func serialize() -> Dictionary:
	var data := .serialize()
	var actions_data := []
	for action in get_children():
		actions_data.append(action.serialize())
	data["actions"] = actions_data
	return data

func deserialize(data: Dictionary):
	.deserialize(data)
	var action_scripts := Dictionary()
	var actions_data = data["actions"]
	for data in actions_data:
		var script_name = data["script"]
		if not action_scripts.has(script_name):
			action_scripts[script_name] = load(script_name)
		var action: Node = Node.new()
		action.set_script(action_scripts[script_name])
		action.deserialize(data)
		add_child(action)
