extends Node

signal energy_changed(max_value, value)

export var max_value = 1000
export var pioneeres_damage = 30
export var pioneeres_food = 30
var value = max_value

func _ready():
	emit_signal("energy_changed", max_value, value)

func _on_HungerTimer_timeout():
	value -= 1
	emit_signal("energy_changed", max_value, value)

func take_damage_from_pioneeres():
	value -= pioneeres_damage
	emit_signal("energy_changed", max_value, value)

func eat_pioneeres():
	value += pioneeres_food
	if value > max_value:
		value = max_value
	emit_signal("energy_changed")
