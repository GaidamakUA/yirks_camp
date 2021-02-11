extends OneFromSetAction

# Execute one action from set. Picking them in order.
class_name OrderAction, "res://assets/class_icons/checkbox-tree.png"

var index := 0

func _get_next_action() -> AtomicAction:
	var old_index := index
	index = (index + 1) % actions.size()
	return actions[old_index]

func _to_string() -> String:
	return "OrderAction"

func serialize() -> Dictionary:
	var data := .serialize()
	data["index"] = index
	return data

func deserialize(data: Dictionary):
	.deserialize(data)
	index = data["index"]
