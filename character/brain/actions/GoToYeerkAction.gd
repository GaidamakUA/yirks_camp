tool

extends AtomicAction

class_name GoToYeerkAction, "res://assets/class_icons/walk.png"

export(float, 1.0, 100) var desired_distance := 10

var navigation

func _perform():
	navigation = brain.navigation
	navigation.set_destination(PlayerInfoSingleton.position, desired_distance)
	yield(navigation, "arrived")
	navigation = null
	_notify_done()

func _process(delta):
	if navigation:
		navigation.set_destination(PlayerInfoSingleton.position, desired_distance)

func drop():
	navigation.drop()

func _to_string() -> String:
	return "GoToYeerkAction" + str(PlayerInfoSingleton.position)
