extends Area2D

signal beeping

onready var sprite = $BeeperSprite

func _on_BeeperButton_input_event(viewport, event, shape_idx):
	if not event is InputEventMouseButton:
		return
	if not event.button_index == BUTTON_LEFT:
		return
	if event.pressed:
		sprite.hide()
		print("beeping")
		emit_signal("beeping")
	else:
		sprite.show()
		print("released")
