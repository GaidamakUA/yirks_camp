tool

extends Node2D

export(bool) var open := false setget _set_opened

onready var open_sprite = $DoorOpen
onready var closed_sprite = $DoorClosed
onready var closed_collision = $StaticBody2D/ClosedShape

var is_ready := false

func _ready():
	is_ready = true

func _set_opened(new_open: bool):
	if not is_ready:
		yield(self, "ready")
	open = new_open
	closed_collision.disabled = open
	if open:
		open_sprite.show()
		closed_sprite.hide()
	else:
		open_sprite.hide()
		closed_sprite.show()
