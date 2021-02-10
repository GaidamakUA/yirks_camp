extends AtomicAction

class_name SayAction, "res://assets/class_icons/chat-bubble.png"

export(String) var replica

var dialog_buble

func _perform():
	dialog_buble = brain.actor.dialog.create_dialog_bubble(replica)
	yield(dialog_buble, "finished_replica")
	_notify_done()

func drop():
	dialog_buble.hide()
	_notify_done()

func _to_string() -> String:
	return "SayAction"

func serialize() -> Dictionary:
	var data := .serialize()
	data["replica"] = replica
	return data

func deserialize(data: Dictionary):
	.deserialize(data)
	replica = data["replica"]
