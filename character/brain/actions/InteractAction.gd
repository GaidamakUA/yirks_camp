extends AtomicAction

class_name InteractAction, "res://assets/class_icons/click.png"

func _perform():
	brain.actor.interact()
	brain.actor.connect("interaction_finished", self, "_on_interaction_finished")

func drop():
	brain.actor.disconnect("interaction_finished", self, "_on_interaction_finished")

func _on_interaction_finished():
	brain.actor.disconnect("interaction_finished", self, "_on_interaction_finished")
	_notify_done()

func _to_string() -> String:
	return "InteractAction"
