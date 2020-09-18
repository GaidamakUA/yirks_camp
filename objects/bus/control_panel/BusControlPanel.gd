extends BaseInteractiveObject

onready var popup = $Popup

func _interact():
	if visible:
		popup.hide()
	else:
		popup.popup()
