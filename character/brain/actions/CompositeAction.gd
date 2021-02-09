extends AtomicAction

class_name CompositeAction, "res://assets/class_icons/stairs-goal.png"

var current_action: AtomicAction
var running

func _perform():
	var actions = get_children()
	running = true
	while running && actions.size() > 0:
		var action: AtomicAction = actions.pop_front()
		current_action = action
		action.perform(brain)
		yield(action, "done")
	_notify_done()

func drop():
	running = false
	current_action.drop()

func _to_string() -> String:
	return "CompositeAction"

func serialize() -> Dictionary:
	var data := .serialize()
	var actions_data := []
	for action in get_children():
		actions_data.append(action.serialize())
	data["actions"] = actions_data
	return data

func deserialize(data: Dictionary):
	.deserialize(data)
	var actions_data = data["actions"]
	for data in actions_data:
		var action: Node = Node.instance()
		action.set_script(data["script"])
		add_child(action)
