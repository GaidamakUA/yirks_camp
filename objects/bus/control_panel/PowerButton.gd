extends BaseClickableArea

signal changed_state(new_state)

var is_on := false

onready var button_pressed = $ButtonPressed
onready var button_idle = $ButtonIdle
onready var pressed_player = $PressedPlayer

func _on_pressed():
	is_on = not is_on
	emit_signal("changed_state", is_on)
	pressed_player.play()
	button_pressed.show()
	button_idle.hide()

func _on_released():
	button_pressed.hide()
	button_idle.show()
