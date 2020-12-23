extends Menu

func _ready():
	_init_fullscreen()

func _init_fullscreen():
	var state := ""
	if OS.window_fullscreen:
		state = "Так"
	else:
		state = "Ні"
	$Fullscreen.text = tr("На весь екран") + ": " + tr(state)

func _on_Fullscreen_pressed():
	OS.window_fullscreen = not OS.window_fullscreen
	_init_fullscreen()

func _on_Audio_pressed():
	OS.alert("Not implemented")

func _on_LanguageOptions_language_changed():
	_init_fullscreen()
