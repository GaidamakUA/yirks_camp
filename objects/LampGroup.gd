tool

extends Node2D

var is_initialized = false

func _ready():
	is_initialized = true

func _on_switch_flipped(is_on):
	if not is_initialized:
		yield(self ,"ready")
	var children = get_children()
	for child in children:
		child._on_switch_flipped(is_on)
