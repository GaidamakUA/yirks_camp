extends AtomicAction

class_name DelayAction, "res://assets/class_icons/pocket-watch.png"

export(float, 1, 30) var wait_time

func drop():
	_notify_done()

func _perform():
	yield(get_tree().create_timer(wait_time), "timeout")
	_notify_done()

func _to_string() -> String:
	return "DelayAction"

func serialize() -> Dictionary:
	var data := .serialize()
	data["wait_time"] = wait_time
	return data

func deserialize(data: Dictionary):
	.deserialize(data)
	wait_time = data["wait_time"]
