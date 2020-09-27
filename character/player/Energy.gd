extends Node

signal energy_changed(value)

export var starting_value = 1000

func _on_HungerTimer_timeout():
	starting_value -= 1
	emit_signal("energy_changed", starting_value)
