extends Node

class_name AtomicAction

signal done(action)

var brain
var icon = ""

func perform(_brain):
	# Should not be touched
	brain = _brain
	print(self, " perform")
	_perform()

func _perform():
	# To be overriden by children
	pass

func _notify_done():
	print(self, " done")
	emit_signal("done", self)

func _to_string() -> String:
	return "AtomicAction"
