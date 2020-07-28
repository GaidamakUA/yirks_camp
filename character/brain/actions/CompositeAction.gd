extends AtomicAction

onready var actions = get_children()

func _perform():
	print(actions)
	_perform_next_action()

func action_finished(action: AtomicAction):
	print(self, " action ", action, " finished")
	action.disconnect("done", self, "action_finished")
	if actions.empty():
		_notify_done()
	_perform_next_action()

func _perform_next_action():
	var action: AtomicAction = actions.pop_front()
	print("next_Action: ", action)
	action.connect("done", self, "action_finished")
	action.perform(brain)
