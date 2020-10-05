extends BaseGoal

class_name ReactOnYeerkGoal

export(int) var priority := 3

func calculate_weight() -> int:
	var sight_cone: Area2D = brain.sight_cone
	var colliding_areas = sight_cone.get_overlapping_areas()
	for area in colliding_areas:
		var parent = area.get_parent()
		if parent is Player:
			return priority
	return 0

func _to_string() -> String:
	return "ReactOnYeerkGoal"
