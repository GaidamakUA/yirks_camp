extends SetAction

# Perform multiple actions
class_name CompositeAction, "res://assets/class_icons/stairs-goal.png"

var is_active := false

func _perform():
	var actions = get_children()
	is_active = true
	while is_active && actions.size() > 0:
		var action: AtomicAction = actions.pop_front()
		current_action = action
		action.perform(brain)
		yield(action, "done")
	_notify_done()

func drop():
	is_active = false
	.drop()

func _to_string() -> String:
	return "CompositeAction"

func serialize() -> Dictionary:
	var data := .serialize()
	data["is_active"] = is_active
	return data

func deserialize(data: Dictionary):
	.deserialize(data)
	is_active = data["is_active"]
