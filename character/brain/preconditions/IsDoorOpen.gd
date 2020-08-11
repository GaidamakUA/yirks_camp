extends Precondition

class_name IsDoorOpen, "res://assets/class_icons/door-open.png"

export(bool) var inverted = false

func is_valid(brain) -> bool:
	var test_area: Area2D = brain.hand_reach_sensor
	var colliding_areas = test_area.get_overlapping_areas()
	for area in colliding_areas:
		var parent = area.get_parent()
		if parent is Door:
			if inverted:
				return not parent.is_open()
			else:
				return parent.is_open()
	return not inverted
