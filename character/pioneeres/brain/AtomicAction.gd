extends Node

class_name AtomicAction

signal done(action)
var actor
var icon = ""

func perform(_actor):
	actor = _actor
	print(self, " perform")
	connect("done", actor.brain, "action_finished")

func _notify_done():
	print(self, " done")
	emit_signal("done", self)
	disconnect("done", actor.brain, "action_finished")

func _to_string() -> String:
	return "AtomicAction"
