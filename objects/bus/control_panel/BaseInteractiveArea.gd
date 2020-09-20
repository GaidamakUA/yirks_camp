extends Area2D

class_name BaseClickableArea

func _on_BaseInteractiveArea_input_event(viewport, event, shape_idx):
	if not event is InputEventMouseButton:
		return
	if not event.button_index == BUTTON_LEFT:
		return
	if event.pressed:
		on_pressed()
	else:
		on_released()

# To be overriden by children
func on_pressed():
	pass

# To be overriden by children
func on_released():
	pass
