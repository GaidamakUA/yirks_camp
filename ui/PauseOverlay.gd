extends CanvasLayer

func _ready():
	$Control.hide()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_toggle_pause()

func _on_ResumeButton_pressed():
	_toggle_pause()

func _on_ExitButton_pressed():
	get_tree().change_scene("res://ui/MainMenu.tscn")

func _toggle_pause():
	get_tree().paused = not get_tree().paused
	if get_tree().paused:
		$Control.show()
	else:
		$Control.hide()

func _on_SaveButton_pressed():
	get_parent().save_data()

func _on_LoadButton_pressed():
	_toggle_pause()
	SettingsSingleton.load_level()
