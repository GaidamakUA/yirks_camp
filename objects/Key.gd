tool

extends Node2D

export(String) var action := "ui_up" setget _set_action

onready var label = $Label

var is_ready := false

func _ready():
	is_ready = true
	init_text()

func _set_action(new_action: String):
	action = new_action
	init_text()

func init_text():
	var code = (InputMap.get_action_list(action)[0] as InputEventKey).scancode
	var key_string = OS.get_scancode_string(code)
	if label:
		label.text = key_string
