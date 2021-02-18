extends Panel

signal close_popup
signal file_selected(file_name)

onready var item_list: ItemList = $MarginContainer/VBoxContainer/ItemList
onready var save_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/SaveButton
onready var filename_input = $MarginContainer/VBoxContainer/HBoxContainer2/FileNameInput

func show():
	.show()
	_update_files()

func _update_files():
	var save_files = SettingsSingleton.get_save_files()
	item_list.clear()
	for file_name in save_files:
		item_list.add_item(file_name)

func _on_ClosePopup_pressed():
	emit_signal("close_popup")

func _on_SaveButton_pressed():
	var file_name: String = filename_input.text.rstrip(" ")
	if not file_name.empty():
		emit_signal("file_selected", file_name)

func _on_ItemList_item_activated(index):
	var selected_file = item_list.get_item_text(index)
	filename_input.text = selected_file
