extends AtomicAction

class_name GoToAction

onready var target: Position2D = $Destination


func perform(actor):
	.perform(actor)
	actor.navigator.set_destination(target.global_position)
	actor.navigator.connect("arrived", self, "_on_navigation_finished")

func _on_navigation_finished():
	_notify_done()
	actor.navigator.disconnect("arrived", self, "_on_navigation_finished")

