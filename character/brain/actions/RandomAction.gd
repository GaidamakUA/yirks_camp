extends AtomicAction

class_name RandomAction, "res://assets/class_icons/rolling-dices.png"

var actions := []
var current_action

func _ready():
	_init_actions()

func _perform():
	actions.shuffle()
	var action = actions[0]
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
	return "RandomAction"
