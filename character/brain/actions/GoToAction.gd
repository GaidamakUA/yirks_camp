tool

extends AtomicAction

class_name GoToAction, "res://assets/class_icons/walk.png"

export(float, 1.0, 100) var desired_distance := 10

var target_position: Vector2
var navigation

func _ready():
	if get_child(0) is Position2D:
		target_position = get_child(0).global_position
	# Otherwise it's loading from save file

func _perform():
	navigation = brain.navigation
	navigation.set_destination(target_position, desired_distance)
	yield(navigation, "arrived")
	navigation = null
	_notify_done()

func drop():
	navigation.drop()

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
	return "GoToAction " + str(target_position)

func serialize() -> Dictionary:
	var data := .serialize()
	data["target_position_x"] = target_position.x
	data["target_position_y"] = target_position.y
	return data

func deserialize(data: Dictionary):
	.deserialize(data)
	target_position.x = data["target_position_x"]
	target_position.y = data["target_position_y"]
