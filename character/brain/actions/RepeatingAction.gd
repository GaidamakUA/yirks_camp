extends AtomicAction

class_name RepeatingAction

var actions := []

func _perform():
	_init_actions()
	while true:
		for action in actions:
			if not is_relevant():
				_notify_done()
				return
			action.perform(brain)
			yield(action, "done")

func _init_actions():
	actions = []
	for child in children:
		if child is AtomicAction:
			actions.append(child)
