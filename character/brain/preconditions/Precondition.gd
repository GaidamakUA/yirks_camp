extends Node

class_name Precondition

export(bool) var inverted = false

func is_valid(_brain) -> bool:
	if inverted:
		return not _is_valid(_brain)
	else:
		return _is_valid(_brain)

#To be overriden by children
func _is_valid(_brain) -> bool:
	return inverted

func serialize() -> Dictionary:
	var data := {
		"script" : get_script().resource_path,
		"inverted" : inverted
	}
	return data

func deserialize(data: Dictionary):
	inverted = data["inverted"]
