extends AtomicAction

class_name CompositeAction, "res://assets/class_icons/stairs-goal.png"

var actions: Array
var current_action: AtomicAction

func _perform():
	actions = get_children()
	_perform_next_action()

func drop():
	current_action.drop()

func action_finished(action: AtomicAction):
	action.disconnect("done", self, "action_finished")
	if actions.empty():
		_notify_done()
	else:
		_perform_next_action()

func _perform_next_action():
	var action: AtomicAction = actions.pop_front()
	current_action = action
	action.connect("done", self, "action_finished")
	action.perform(brain)
