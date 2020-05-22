tool

extends Node2D

export(String) var text := "A" setget _set_text

onready var label = $Label

var is_ready := false

func _ready():
	is_ready = true

func _set_text(new_text: String):
	if not is_ready:
		yield(self, "ready")
	text = new_text
	label.text = text
