extends BaseInteractiveObject

signal looked_at

func _interact():
	emit_signal("looked_at")
