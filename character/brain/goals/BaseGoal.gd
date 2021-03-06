extends Node

class_name BaseGoal

const INVALID_WEIGHT := -1

export(int) var priority := 1
var weight := 0

onready var brain = get_parent().get_parent()
onready var actions: Array
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
		current_action.disconnect("done", self, "action_finished")
		current_action.drop()
		current_action = null

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

func serialize():
	var actions_data := []
	for action in get_children():
		actions_data.append(action.serialize())
	var data := {
		"script" : get_script().resource_path,
		"weight" : weight,
		"actions" : actions_data,
		"priority" : priority,
	}
	return data

func deserialize(data: Dictionary):
	weight = data["weight"]
	priority = data["priority"]
	
	actions = []
	var action_scripts := Dictionary()
	var actions_data = data["actions"]
	for data in actions_data:
		var script_name = data["script"]
		if not action_scripts.has(script_name):
			action_scripts[script_name] = load(script_name)
		var action = Node.new()
		action.set_script(action_scripts[script_name])
		action.deserialize(data)
		actions.append(action)
		call_deferred("add_child", action)
