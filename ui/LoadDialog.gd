extends Panel

signal close_popup
signal load_triggered

onready var item_list: ItemList = $MarginContainer/VBoxContainer/ItemList
onready var load_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/LoadSave

func show():
	.show()
	_update_files()

func _update_files():
	var save_files = SettingsSingleton.get_save_files()
	item_list.clear()
	for file_name in save_files:
		item_list.add_item(file_name)

func _is_loading_possible() -> bool:
	var selected_items = item_list.get_selected_items()
	return selected_items.size() == 1

func _on_ClosePopup_pressed():
	emit_signal("close_popup")

func _on_LoadSave_pressed():
	if not _is_loading_possible():
		return
	var selected_items = item_list.get_selected_items()
	var selected_file = item_list.get_item_text(selected_items[0])
	emit_signal("load_triggered")
	SettingsSingleton.load_level(selected_file)

func _on_ItemList_item_activated(index):
	var selected_file = item_list.get_item_text(index)
	SettingsSingleton.load_level(selected_file)
