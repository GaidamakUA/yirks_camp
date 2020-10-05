extends BaseGoal

class_name PersueYeerkGoal

export(int) var priority := 2

func calculate_weight() -> int:
	var test_area: Area2D = brain.hand_reach_sensor
	var colliding_areas = test_area.get_overlapping_areas()
	for area in colliding_areas:
		var parent = area.get_parent()
		if parent is Player:
			return 0
	return priority

func _to_string() -> String:
	return "PersueYeerkGoal"
