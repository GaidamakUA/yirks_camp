tool

extends BaseClickableArea

signal changed_state(new_state)

export var is_on := false setget _set_is_on

onready var button_on = $ButtonOn
onready var button_off = $ButtonOff
onready var on_player = $OnPlayer
onready var off_player = $OffPlayer

var is_ready := false

func _ready():
	is_ready = true

func _on_pressed():
	_set_is_on(not is_on)
	_play_sound()

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
	emit_signal("changed_state", is_on)

func _play_sound():
	if is_on:
		on_player.play()
	else:
		off_player.play()
