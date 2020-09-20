extends Node2D

signal beeping
signal back_door_new_state(new_state)
signal front_door_new_state(new_state)

func _on_BeeperButton_beeping():
	emit_signal("beeping")


func _on_BackDoorsSwitch_changed_state(new_state):
	emit_signal("back_door_new_state", new_state)

func _on_FronDoorsSwitch_changed_state(new_state):
	emit_signal("front_door_new_state", new_state)
