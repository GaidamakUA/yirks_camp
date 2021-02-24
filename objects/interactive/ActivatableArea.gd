extends BaseInteractiveObject

signal area_activated

func _interact():
	emit_signal("area_activated")
