extends AtomicAction

class_name DelayAction, "res://assets/class_icons/pocket-watch.png"

export(float, 1, 30) var wait_time

func drop():
	_notify_done()

func _perform():
	yield(get_tree().create_timer(5.0), "timeout")
	_notify_done()

func _to_string() -> String:
	return "DelayAction"
