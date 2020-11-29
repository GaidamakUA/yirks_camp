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
