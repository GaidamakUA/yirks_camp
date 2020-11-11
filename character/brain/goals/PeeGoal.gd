extends BaseGoal

class_name PeeGoal

onready var bladder: Bladder

export(int) var priority := 3

func calculate_weight() -> int:
	if not bladder:
		bladder = brain.bladder
	if bladder.is_full():
		return priority
	else:
		return 0

func _to_string() -> String:
	if bladder:
		return "PeeGoal {pee_level}".format({"pee_level":bladder.pee_level})
	else:
		return "PeeGoal"
