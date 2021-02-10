extends SetAction

class_name RepeatingAction, "res://assets/class_icons/cycle.png"

var is_active := false

func _perform():
	is_active = true
	while is_active:
		for action in actions:
			current_action = action
			if not is_relevant():
				_notify_done()
				return
			action.perform(brain)
			yield(action, "done")
			current_action = null
	_notify_done()

func drop():
	is_active = false
	.drop()

func _to_string() -> String:
	return "RepeatingAction"

func serialize() -> Dictionary:
	var data := .serialize()
	data["is_active"] = is_active
	return data

func deserialize(data: Dictionary):
	.deserialize(data)
	is_active = data["is_active"]
