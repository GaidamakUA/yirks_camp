extends BaseInteractiveObject

signal back_door_new_state(new_state)
signal front_door_new_state(new_state)
signal start_engine

onready var popup = $ControlPanelPopup
var popup_shown = false

func _interact():
	popup_shown = !popup_shown
	if popup_shown:
		popup.show()
	else:
		popup.hide()


func _on_ControlPanelPopup_back_door_new_state(new_state):
	emit_signal("back_door_new_state", new_state)


func _on_ControlPanelPopup_front_door_new_state(new_state):
	emit_signal("front_door_new_state", new_state)

func _player_exited():
	popup_shown = false
	popup.hide()

func _on_ControlPanelPopup_start_engine():
	emit_signal("start_engine")
