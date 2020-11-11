extends BaseGoal

class_name NearFireGoal

export(int) var priority := 2

func calculate_weight() -> int:
	var test_area: Area2D = brain.hand_reach_sensor
	var colliding_areas = test_area.get_overlapping_areas()
	for area in colliding_areas:
		var parent = area.get_parent()
		if parent is GatheringSpot:
			var gathering_place = parent.get_gathering_place()
			if not gathering_place.has_room():
				return priority
			else:
				return INVALID_WEIGHT
	return INVALID_WEIGHT

func _to_string() -> String:
	return "NearFireGoal"
