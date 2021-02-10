extends OneFromSetAction

# Execute one action from set. Picking one at random.
class_name RandomAction, "res://assets/class_icons/rolling-dices.png"

func _get_next_action() -> AtomicAction:
	return actions[randi() % actions.size()]

func _to_string() -> String:
	return "RandomAction"
