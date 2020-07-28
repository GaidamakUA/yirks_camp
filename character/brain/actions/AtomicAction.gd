extends Node

class_name AtomicAction, "res://assets/class_icons/check-mark.png"

signal done(action)

onready var children = get_children()
var preconditions = []

var brain

func _ready():
	for child in children:
		if child is Precondition:
			preconditions.append(child)

func perform(_brain):
	# Should not be touched
	brain = _brain
	if not is_relevant():
		_notify_done()
		return
	print(self, " perform")
	_perform()

func is_relevant() -> bool:
	if preconditions.empty():
		return true
	for precondition in preconditions:
		if not precondition.is_valid(brain):
			return false
	return true

func _perform():
	# To be overriden by children
	pass

func _notify_done():
	print(self, " done")
	emit_signal("done", self)

func _to_string() -> String:
	return "AtomicAction"
