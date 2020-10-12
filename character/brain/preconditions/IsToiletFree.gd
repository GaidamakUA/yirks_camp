extends Precondition

class_name IsToiletFree, "res://assets/class_icons/toilet.png"

func _is_valid(brain) -> bool:
	var test_area: Area2D = brain.hand_reach_sensor
	var colliding_areas = test_area.get_overlapping_areas()
	for area in colliding_areas:
		var parent = area.get_parent()
		if parent is Toilet:
			return parent.is_free()
	return false
