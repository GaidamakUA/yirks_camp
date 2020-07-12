extends Node

class_name AtomicAction

signal done(action)

var brain
var icon = ""

func perform(_brain):
	brain = _brain
	print(self, " perform")
	connect("done", brain, "action_finished")

func _notify_done():
	print(self, " done")
	emit_signal("done", self)
	disconnect("done", brain, "action_finished")

func _to_string() -> String:
	return "AtomicAction"
