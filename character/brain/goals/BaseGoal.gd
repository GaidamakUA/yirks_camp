extends Node

const INVALID_WEIGHT := -1

onready var brain = get_parent()
var actions: Array

# Should be modified in children
var weight := 0

func _recalculate_weight():
	pass

func _persue():
	actions = get_children()
	print("persue ", self, " ", actions)
	_perform_next_action()

func action_finished(action: AtomicAction):
	print(self, " action ", action, " finished")
	action.disconnect("done", self, "action_finished")
	if actions.empty():
		_notify_done()
	else:
		_perform_next_action()

func _perform_next_action():
	var action: AtomicAction = actions.pop_front()
	print("next_Action: ", action)
	action.connect("done", self, "action_finished")
	action.perform(brain)

func _notify_done():
	weight = INVALID_WEIGHT

func _to_string() -> String:
	return "BaseGoal"
