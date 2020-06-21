extends Position2D

const Dialog = preload("res://character/communication/dialog/DialogBox.tscn")

func say(text: String):
	var dialog = Dialog.instance()
	add_child(dialog)
	dialog.post_text(text)
