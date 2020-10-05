extends Precondition

class_name IsSeeingYeerk

export(bool) var inverted = false

func is_valid(brain) -> bool:
	var sight_cone: Area2D = brain.sight_cone
	var colliding_areas = sight_cone.get_overlapping_areas()
	for area in colliding_areas:
		var parent = area.get_parent()
		if parent is Toilet:
			if inverted:
				return not parent.is_free()
			else:
				return parent.is_free()
	return not inverted
