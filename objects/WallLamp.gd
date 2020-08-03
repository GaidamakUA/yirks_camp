tool

extends Node2D

onready var light = $Light

func _on_switch_flipped(is_on):
	light.visible = is_on
