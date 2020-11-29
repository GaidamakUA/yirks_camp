extends AtomicAction

class_name OrderAction, "res://assets/class_icons/checkbox-trees.png"

var actions := []
var index = 0

var current_action

func _ready():
	_init_actions()

func _perform():
	index = (index + 1) % actions.size()
	var action = actions[index]
	current_action = action
	action.perform(brain)
	yield(action, "done")
	current_action = null
	_notify_done()

func drop():
	if current_action:
		current_action.drop()

func _init_actions():
	actions = []
	for child in children:
		if child is AtomicAction:
			actions.append(child)

func _to_string() -> String:
	return "OrderAction"
