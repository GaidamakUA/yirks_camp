extends AtomicAction

class_name SayAction, "res://assets/class_icons/chat-bubble.png"

export(String) var replica

var dialog_buble

func _perform():
	dialog_buble = brain.actor.dialog.create_dialog_bubble(replica)
	dialog_buble.connect("finished_replica", self, "_on_replica_finished")

func _on_replica_finished():
	dialog_buble.disconnect("finished_replica", self, "_on_replica_finished")
	_notify_done()

func _to_string() -> String:
	return "SayAction"
