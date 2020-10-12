tool

extends AtomicAction

class_name GoToAction, "res://assets/class_icons/walk.png"

export(float, 1.0, 100) var desired_distance := 10

onready var target: Position2D = get_child(0)
var navigation

func _perform():
	navigation = brain.navigation
	navigation.set_destination(target.global_position, desired_distance)
	navigation.connect("arrived", self, "_on_navigation_finished")

func _process(delta):
	if navigation:
		navigation.set_destination(target.global_position, desired_distance)

func drop():
	navigation.drop()
	navigation.disconnect("arrived", self, "_on_navigation_finished")
	navigation = null

func _on_navigation_finished():
	_notify_done()
	navigation.disconnect("arrived", self, "_on_navigation_finished")
	navigation = null

func _get_configuration_warning() -> String:
	if get_child_count() == 0:
		return "Should have destination"
	elif get_child_count() > 1 + preconditions.size():
		return "Should not have anything accept destination"
	if not get_child(0) is Position2D:
		return "Destination should be Position2D"
	else:
		return ""

func _to_string() -> String:
	return "GoToAction" + str(target.global_position)
