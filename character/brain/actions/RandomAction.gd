extends AtomicAction

class_name RandomAction

var actions := []

func _ready():
	_init_actions()

func _perform():
	actions.shuffle()
	var action = actions[0]
	action.perform(brain)
	yield(action, "done")
	_notify_done()

func _init_actions():
	actions = []
	for child in children:
		if child is AtomicAction:
			actions.append(child)
