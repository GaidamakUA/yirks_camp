extends Panel

signal language_changed

func _on_English_pressed():
	TranslationServer.set_locale("en")
	hide()
	emit_signal("language_changed")

func _on_Ukrainian_pressed():
	TranslationServer.set_locale("uk")
	hide()
	emit_signal("language_changed")


func _on_ClosePopup_pressed():
	hide()
