extends SetAction

# Execute one action from set. Base class, do not instantiate.
class_name OneFromSetAction

func _perform():
	var action: AtomicAction = _get_next_action()
	current_action = action
	action.perform(brain)
	yield(action, "done")
	current_action = null
	_notify_done()

# Should be overwritten by children
func _get_next_action() -> AtomicAction:
	return actions[0]

func _to_string() -> String:
	return "OneFromSetAction should be overwritten"
