extends AtomicAction

class_name GoToAction, "res://assets/class_icons/walk.png"

onready var target: Position2D = $Destination
var navigation

func _perform():
	navigation = brain.find_node("Navigation")
	navigation.set_destination(target.global_position)
	navigation.connect("arrived", self, "_on_navigation_finished")

func _on_navigation_finished():
	_notify_done()
	navigation.disconnect("arrived", self, "_on_navigation_finished")
	navigation = null
