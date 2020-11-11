extends AtomicAction

class_name OrderAction

var actions := []
var index = 0

func _ready():
	_init_actions()

func _perform():
	index = (index + 1) % actions.size()
	var action = actions[index]
	action.perform(brain)
	yield(action, "done")
	_notify_done()

func _init_actions():
	actions = []
	for child in children:
		if child is AtomicAction:
			actions.append(child)
