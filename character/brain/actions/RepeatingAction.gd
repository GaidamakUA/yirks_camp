extends AtomicAction

class_name RepeatingAction, "res://assets/class_icons/cycle.png"

var actions := []
var is_active := false
var current_action

func _perform():
	_init_actions()
	is_active = true
	while is_active:
		for action in actions:
			current_action = action
			if not is_relevant():
				_notify_done()
				return
			action.perform(brain)
			yield(action, "done")
			current_action = null
	_notify_done()

func drop():
	is_active = false
	if current_action:
		current_action.drop()

func _init_actions():
	actions = []
	for child in children:
		if child is AtomicAction:
			actions.append(child)

func _to_string() -> String:
	return "RepeatingAction"
