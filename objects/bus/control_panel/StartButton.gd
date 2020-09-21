extends BaseClickableArea

signal pressed

onready var button_pressed = $ButtonPressed
onready var button_idle = $ButtonIdle
onready var pressed_player = $PressedPlayer

func _on_pressed():
	emit_signal("pressed")
	pressed_player.play()
	button_pressed.show()
	button_idle.hide()

func _on_released():
	button_pressed.hide()
	button_idle.show()
