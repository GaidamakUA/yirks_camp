extends Node

signal energy_changed(max_value, value)

export var max_value = 1000
var value = max_value

func _ready():
	emit_signal("energy_changed", max_value, value)

func _on_HungerTimer_timeout():
	value -= 1
	emit_signal("energy_changed", max_value, value)
