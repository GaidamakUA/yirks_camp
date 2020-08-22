tool

extends AtomicAction

class_name GoToAction, "res://assets/class_icons/walk.png"

onready var target: Position2D = get_child(0)
var navigation
var is_performing := false

func _perform():
	navigation = brain.navigation
	navigation.set_destination(target.global_position)
	navigation.connect("arrived", self, "_on_navigation_finished")
	is_performing = true

func _process(delta):
	if not is_performing:
		return
	navigation.set_destination(target.global_position)

func drop():
	is_performing = false
	navigation.drop()

func _on_navigation_finished():
	is_performing = false
	_notify_done()
	navigation.disconnect("arrived", self, "_on_navigation_finished")
	navigation = null

func _get_configuration_warning() -> String:
	if get_child_count() == 0:
		return "Should have destination"
	elif get_child_count() > 1:
		return "Should not have anything accept destination"
	if not get_child(0) is Position2D:
		return "Destination should be Position2D"
	else:
		return ""
