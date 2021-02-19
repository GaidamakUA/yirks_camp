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
	get_tree().paused = false

func _toggle_pause():
	get_tree().paused = not get_tree().paused
	if get_tree().paused:
		$Control.show()
	else:
		_close_dialog()
		$Control.hide()

func _on_SaveButton_pressed():
	$Control/Panel.hide()
	$Control/SaveDialog.show()

func _on_LoadButton_pressed():
	$Control/Panel.hide()
	$Control/LoadDialog.show()

func _close_dialog():
	$Control/Panel.show()
	$Control/LoadDialog.hide()
	$Control/SaveDialog.hide()

func _on_LoadSaveDialog_load_triggered():
	get_tree().paused = false

func _on_SaveDialog_file_selected(filename):
	var data = get_parent().serialize()
	SettingsSingleton.save_level(filename, data)
	$Control/SaveDialog._update_files()
