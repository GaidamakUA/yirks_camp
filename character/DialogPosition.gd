extends Position2D

const Dialog = preload("res://character/communication/dialog/DialogBox.tscn")

func create_dialog_bubble(text: String):
	var dialog = Dialog.instance()
	add_child(dialog)
	dialog.post_text(text)
	return dialog
