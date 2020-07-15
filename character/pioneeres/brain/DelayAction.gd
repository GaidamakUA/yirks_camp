extends AtomicAction

class_name DelayAction

export(float, 1, 30) var wait_time

func _ready():
	icon = "sleep"
	
func perform(actor):
	.perform(actor)
	$Timer.start(wait_time)

func _on_Timer_timeout():
	_notify_done()

func _to_string() -> String:
	return "DelayAction"
