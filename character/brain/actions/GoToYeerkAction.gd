tool

extends AtomicAction

class_name GoToYeerkAction, "res://assets/class_icons/walk.png"

export(float, 1.0, 100) var desired_distance := 10

var navigation
var active := false

func _perform():
	active = true
	navigation = brain.navigation
	navigation.set_destination(PlayerInfoSingleton.position, desired_distance)
	yield(navigation, "arrived")
	navigation = null
	active = false
	_notify_done()

func _process(delta):
	if navigation && active:
		navigation.set_destination(PlayerInfoSingleton.position, desired_distance)

func drop():
	active = false
	navigation.drop()

func _to_string() -> String:
	return "GoToYeerkAction " + str(PlayerInfoSingleton.position)
