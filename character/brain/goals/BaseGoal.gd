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
	_perform_next_action()

func drop():
	if current_action:
		current_action.drop()

func is_finished() -> bool:
	return current_action == null

func action_finished(action: AtomicAction):
	action.disconnect("done", self, "action_finished")
	if actions.size() > 0:
		_perform_next_action()
	else:
		current_action = null

func _perform_next_action():
	current_action = actions.pop_front()
	current_action.connect("done", self, "action_finished")
	current_action.perform(brain)

func _to_string() -> String:
	return "BaseGoal"

func save():
	var actions_data := []
	for action in actions:
		actions_data.append(action.save())
	var data := {
		"script" : get_script().resource_path,
		"weight" : weight,
		"actions" : actions_data,
	}
	return data
