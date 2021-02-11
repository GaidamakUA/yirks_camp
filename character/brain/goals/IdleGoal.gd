extends BaseGoal

class_name IdleGoal

func calculate_weight() -> int:
	return priority

func _to_string() -> String:
	return "IdleGoal"
