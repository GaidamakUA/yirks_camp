extends BaseGoal

class_name PeeGoal

onready var bladder: Bladder

func calculate_weight() -> int:
	if not bladder:
		bladder = brain.bladder
	if bladder.is_full():
		return priority
	else:
		return 0

func _to_string() -> String:
	if bladder:
		return "PeeGoal:\nPee = {pee_level}\nAction = {action}".format({"pee_level":bladder.pee_level, "action":current_action})
	else:
		return "PeeGoal"
