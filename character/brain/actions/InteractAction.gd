extends AtomicAction

class_name InteractAction, "res://assets/class_icons/click.png"

func _perform():
	brain.actor.interact()
	yield(brain.actor, "interaction_finished")
	_notify_done()

func drop():
	pass

func _to_string() -> String:
	return "InteractAction"
