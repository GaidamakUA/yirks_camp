extends AtomicAction

class_name DelayAction, "res://assets/class_icons/pocket-watch.png"

export(float, 1, 30) var wait_time

onready var timer = Timer.new()

func _ready():
	add_child(timer)
	timer.connect("timeout", self, "_on_Timer_timeout")

func _perform():
	timer.start(wait_time)

func _on_Timer_timeout():
	_notify_done()

func _to_string() -> String:
	return "DelayAction"
