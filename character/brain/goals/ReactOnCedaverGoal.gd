extends BaseGoal

class_name ReactOnCedaverGoal

export(int) var priority := 3

func calculate_weight() -> int:
	var sight_cone: Area2D = brain.sight_cone
	var colliding_bodies = sight_cone.get_overlapping_bodies()
	for body in colliding_bodies:
		if body is Cedaver:
			return priority
	return 0

func _to_string() -> String:
	return "ReactOnYeerkGoal"
