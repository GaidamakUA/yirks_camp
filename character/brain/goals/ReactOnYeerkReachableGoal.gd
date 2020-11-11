extends BaseGoal

class_name ReactOnYeerkReachableGoal

export(int) var priority := 5

func calculate_weight() -> int:
	var hit_reach_sensor: Area2D = brain.hit_reach_sensor
	var colliding_areas = hit_reach_sensor.get_overlapping_areas()
	for area in colliding_areas:
		var parent = area.get_parent()
		if parent is Player && parent.is_visible():
			return priority
	return 0

func _to_string() -> String:
	return "ReactOnYeerkGoal"
