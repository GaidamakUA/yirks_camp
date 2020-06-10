extends Control

var yeerk_displacement = Vector2(-32, 32)

onready var yeerk_face = $YeerkFace

onready var main_menu = $MainMenu
onready var level_menu = $LevelMenu

func _input(event):
	if event is InputEventMouseMotion:
		var  mouse_position = event.position
		var viewport_size = get_viewport_rect().size
		var delta = mouse_position / viewport_size * yeerk_displacement
		yeerk_face.rect_position = yeerk_displacement - delta

func _on_PickLevelButton_pressed():
	main_menu.set_shown(false)
	level_menu.set_shown(true)


func _on_TestLevel_pressed():
	get_tree().change_scene("res://levels/TestLevel2.tscn")

func _on_Level1_pressed():
	get_tree().change_scene("res://levels/Level1.tscn")
