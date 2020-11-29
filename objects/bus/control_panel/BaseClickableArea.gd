extends Area2D

class_name BaseClickableArea

func _on_BaseInteractiveArea_input_event(viewport, event, shape_idx):
	if not event is InputEventMouseButton:
		return
	if not event.button_index == BUTTON_LEFT:
		return
	if event.pressed:
		_on_pressed()
	else:
		_on_released()

# To be overriden by children
func _on_pressed():
	pass

# To be overriden by children
func _on_released():
	pass
