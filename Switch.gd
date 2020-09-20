tool

extends BaseClickableArea

export var is_on := false setget _set_is_on

onready var button_off = $ButtonOff
onready var button_on = $ButtonOn

var is_ready := false

func _ready():
	is_ready = true

func on_pressed():
	_set_is_on(not is_on)

func _set_is_on(new_is_on: bool):
	if not is_ready:
		yield(self, "ready")
	is_on = new_is_on
	if is_on:
		button_off.hide()
		button_on.show()
	else:
		button_off.show()
		button_on.hide()
