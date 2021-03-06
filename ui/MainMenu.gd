extends Control

var yeerk_displacement = Vector2(-32, -32)
onready var yeerk_position = $YeerkFace.rect_position

onready var yeerk_face = $YeerkFace

onready var main_menu = $MainMenu
onready var options_menu = $OptionsMenu
onready var load_save = $LoadSaveDialog

func _ready():
	PlayerInfoSingleton.reset()

func _input(event):
	if event is InputEventMouseMotion:
		var  mouse_position = event.position
		var viewport_size = get_viewport_rect().size
		var delta = mouse_position / viewport_size * yeerk_displacement
		yeerk_face.rect_position = yeerk_position - delta

# Main menu

func _on_SettingsButton_pressed():
	main_menu.menu_hide()
	options_menu.menu_show()

func _on_BackToMain_pressed():
	main_menu.menu_show()
	options_menu.menu_hide()
	load_save.hide()
	SettingsSingleton.save_settings()

# Levels
func _on_TestLevel_pressed():
	get_tree().change_scene("res://levels/TestLevel2.tscn")

func _on_Level1_pressed():
	get_tree().change_scene("res://levels/Level1.v2.tscn")

func _on_Level2Mine_pressed():
	get_tree().change_scene("res://levels/Level2.Mine.tscn")

func _on_Language_pressed():
	$LanguageOptions.show()

func _on_Controls_pressed():
	$ControlsOptions.show()

func _on_ControlsOptions_controls_changed():
	SettingsSingleton.save_control_scheme()

func _on_LoadButton_pressed():
	main_menu.menu_hide()
	load_save.show()
