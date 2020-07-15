extends AtomicAction

class_name InteractAction

func _ready():
	icon = "idea"

func perform(actor):
	.perform(actor)
	actor.interact()
	actor.connect("interaction_finished", self, "_on_interaction_finished")

func _on_interaction_finished():
	actor.disconnect("interaction_finished", self, "_on_interaction_finished")
	_notify_done()

func _to_string() -> String:
	return "InteractAction"
