extends Node

class_name BaseGoal

const INVALID_WEIGHT := -1

var weight := 0

onready var brain = get_parent().get_parent()
var actions: Array
var current_action: AtomicAction

func update_weight():
	weight = calculate_weight()

func calculate_weight() -> int:
	return INVALID_WEIGHT

func persue():
	actions = get_children()
	print("persue ", self, " ", actions)
	_perform_next_action()

func drop():
	if current_action:
		current_action.drop()

func action_finished(action: AtomicAction):
	print(self, " action ", action, " finished")
	action.disconnect("done", self, "action_finished")
	if actions.size() > 0:
		_perform_next_action()

func _perform_next_action():
	var action: AtomicAction = actions.pop_front()
	print("next_Action: ", action)
	action.connect("done", self, "action_finished")
	action.perform(brain)

func _to_string() -> String:
	return "BaseGoal"
