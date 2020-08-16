extends AtomicAction

class_name EmptyBladderAction, "res://assets/class_icons/toilet.png"

func _perform():
	brain.bladder.reset_pee_level()
	_notify_done()

func drop():
	pass

func _to_string() -> String:
	return "EmptyBladderAction"
