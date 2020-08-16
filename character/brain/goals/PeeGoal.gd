extends BaseGoal

class_name PeeGoal

onready var bladder: Bladder

export(float, 0.5, 1.0) var pee_threshhold := 0.8
export(int) var priority := 2

func calculate_weight() -> int:
	if not bladder:
		bladder = brain.bladder
	if bladder.pee_level > pee_threshhold:
		return priority
	else:
		return 0

func _to_string() -> String:
	if bladder:
		return "PeeGoal {pee_level}".format({"pee_level":bladder.pee_level})
	else:
		return "PeeGoal"
